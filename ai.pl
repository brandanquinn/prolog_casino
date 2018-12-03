/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************
* AI Help Logic            *                  
***************************/

/**
Clause Name: tryIncrease
Purpose: AI tries to increase and claim an opponent's build.
Parameters:
        State, List of all variables used in game state.
        Builds, List of current builds on the table.
        StaticHand, List of cards in player's hand. Is not changed.
        DynamicHand, List of cards in player's hand to iterate through and select certain cards.
**/
tryIncrease(State, Builds, StaticHand, _) :-
        Builds = [],
        tryBuild(State, [], StaticHand, StaticHand).

tryIncrease(State, Builds, StaticHand, []) :-
        tryExtendBuild(State, Builds, StaticHand, StaticHand).

tryIncrease(State, Builds, StaticHand, DynamicHand) :-
        % Try to increase a build for each combination of cards in your hand.
        [CardSelected | Rest] = DynamicHand,
        checkCardsPlayed(State, CardSelected, StaticHand, increase),
        tryIncrease(State, Builds, StaticHand, Rest).


/**
Clause Name: tryExtendBuild
Purpose: AI tries to extend player's build to a multi-build.
Parameters:
        State, List of all variables used in game state.
        Builds, List of current builds on the table.
        StaticHand, List of cards in player's hand. Is not changed.
        DynamicHand, List of cards in player's hand to iterate through and select certain cards.
**/
tryExtendBuild(State, Builds, StaticHand, []) :-
        % No builds have been found to extend, testing create new build now.
        tryBuild(State, Builds, StaticHand, StaticHand).

tryExtendBuild(State, Builds, StaticHand, DynamicHand) :-
        [CardSelected | Rest] = DynamicHand,
        checkCardsPlayed(State, CardSelected, StaticHand, extend),
        tryExtendBuild(State, Builds, StaticHand, Rest).    

/**
Clause Name: tryBuild
Purpose: AI tries to create a new build.
Parameters:
        State, List of all variables used in game state.
        Builds, List of current builds on the table.
        StaticHand, List of cards in player's hand. Is not changed.
        DynamicHand, List of cards in player's hand to iterate through and select certain cards. 
**/
tryBuild(State, _, StaticHand, []) :-
        % Cannot create any new builds, testing capture values.
        tryCapture(State, StaticHand).
    
tryBuild(State, Builds, StaticHand, DynamicHand) :-
        [CardSelected | Rest] = DynamicHand,
        checkCardsPlayed(State, CardSelected, StaticHand, build),
        tryBuild(State, Builds, StaticHand, Rest).


/**
Clause Name: tryCapture
Purpose: Generates the capture heuristics for each card in player's hand and makes the best move accordingly.
Parameters:
        State, List of current variables used in game state.
        PlayerHand, List of cards in player's hand.
**/
tryCapture(State, PlayerHand) :-
        getTableCardsFromState(State, TableCards),
        getBuildsFromState(State, Builds),
        generateCaptureHeuristics(PlayerHand, TableCards, Builds, _, HeuristicsList),
        findMaxHeuristicOfList(HeuristicsList, MaxHeuristic, Index),
        assessMaxHeuristic(State, PlayerHand, Index, MaxHeuristic),
        nth0(Index, PlayerHand, BestCard),
        aiCapture(State, TableCards, Builds, BestCard).

/**
Clause Name: assessMaxHeuristic
Purpose: Assesses best heuristic value, if best value is 0, trails.
Parameters:
        State, List of variables used in current game state.
        PlayerHand, List of cards in player's hand.
        Index, Index of max heuristic value.
        MaxHeuristic, Max heuristic value.
**/
assessMaxHeuristic(State, PlayerHand, Index, MaxHeuristic) :-
        MaxHeuristic \= 0,
        write('Best heuristic value is: '), write(MaxHeuristic),
        nth0(Index, PlayerHand, BestCard),
        write(' corresponding to card: '), printCards([BestCard]), nl.

assessMaxHeuristic(State, PlayerHand, _, 0) :-
        write('No other moves found, trailing first card in hand.'), nl,
        [CardSelected | _] = PlayerHand,
        getTableCardsFromState(State, TableCards),
        getPlayNextFromState(State, CurrentPlayer),
        getInputIfHuman(State, CardSelected, CurrentPlayer),
        trail(State, CardSelected, TableCards, _, PlayerHand, _).

/**
Clause Name: getInputIfHuman
Purpose: If player is human, ask them if they want to trail recommended AI card.
Parameters:
        State, List of variables used in current game state.
        CardSelected, Card selected to trail.
        CurrentPlayer, Player currently getting help from AI.
**/
getInputIfHuman(_, _, computer).

getInputIfHuman(State, CardSelected, human) :-
        write('AI recommends to trail: '), printCards([CardSelected]), write('will you make this move? (y/n): '),
        read(Input),
        assessAITrail(State, Input).


/**
Clause Name: assessAITrail
Purpose: Assess input from human player as to whether or not they want to make AI selected trail. If not, restarts turn.
**/
assessAITrail(_, y).

assessAITrail(State, n) :-
        write('Player selected not to make AI recommended move. Restarting turn.'), nl,
        assessRound(State).

assessAITrail(State, _) :-
        write('Invalid input. Try again.'), nl,
        assessRound(State).


/**
Clause Name: generateCaptureHeuristics
Purpose: Assesses each card in player's hand and generates capture heuristics depending on how many cards can be added to pile with each move.
Parameters:
        Hand, Player's hand being assessed.
        TableCards, Cards on the table.
        Builds, Builds on the table.
        HeuristicsIn, Uninstantiated list to generate heuristics within clause.
        HeuristicsOut, Uninstantiated list to pass heuristics list out of clause.
**/
generateCaptureHeuristics([], _, _, HeuristicsIn, HeuristicsOut) :- HeuristicsOut = HeuristicsIn.

generateCaptureHeuristics(Hand, TableCards, Builds, HeuristicsIn, HeuristicsOut) :-
        [CardPlayed | Rest] = Hand,
        getCapturableCards(TableCards, CardPlayed, _, CapturableLooseCards),
        getLengthOfList(CapturableLooseCards, NumberOfLooseCards),
        removeCardsFromList(CapturableLooseCards, TableCards, TableCardsAfterSameVal),
        getCapturableBuilds(CardPlayed, Builds, _, CapturableBuilds),
        getTotalCardsInBuilds(CapturableBuilds, 0, BuildCardsCaptured),
        % getLengthOfList(CapturableBuilds, BuildCardsCaptured),
        getCapturableSetsForAI(CardPlayed, TableCardsAfterSameVal, CapturableSets),
        getLengthOfList(CapturableSets, NumberOfSets),
        HeuristicVal is NumberOfLooseCards + BuildCardsCaptured + NumberOfSets,
        append(HeuristicsIn, [HeuristicVal], TempList),
        generateCaptureHeuristics(Rest, TableCards, Builds, TempList, HeuristicsOut).

/**
Clause Name: getTotalCardsInBuilds
Purpose: Get total number of cards in capturable builds in order to accurately generate and assess heuristic value of move.
Parameters:
    Builds, Capturable builds recommended by AI.
    LengthIn, Starting at 0, increments by length of each build.
    LengthOut, U/I variable to pass final length calculated out of clause.
**/
getTotalCardsInBuilds([], LengthIn, LengthIn).

getTotalCardsInBuilds(Builds, LengthIn, LengthOut) :-
    [Build | Rest] = Builds,
    flattenList(Build, _, BuildList),
    getLengthOfList(BuildList, NewLength),
    TempLength is LengthIn + NewLength,
    getTotalCardsInBuilds(Rest, TempLength, LengthOut).

/**
Clause Name: getCapturableSetsForAI
Purpose: Finds all capturable sets by played card for AI.
Parameters:
        CardPlayed, card being assessed by AI for capture.
        TableCards, loose cards to capture on the table.
        CapturableSets, List of sets that can be captured by playing card.
**/
getCapturableSetsForAI(CardPlayed, TableCards, CapturableSets) :-
        getAllSubsets(TableCards, SubsetList),
        removeCardFromList([], SubsetList, UpdatedList),
        getValue(CardPlayed, CaptureValue),
        findCapturableSubsets(TableCards, UpdatedList, CaptureValue, _, CapturableSets).

/**
Clause Name: checkCardsPlayed
Purpose: Iterates through hand and tries to play each card into a build
Parameters:
        State, List of all variables used in game state.
        CardSelected, Card selected to try to sum build to.
        Hand, Player's hand to iterate and test cards to play.
        MoveType, Move type selected to test by AI.
**/
checkCardsPlayed(State, CardSelected, [], MoveType) :-
        MoveType = increase,
        getPlayNextFromState(State, CurrentPlayer),
        getCurrentPlayersHand(State, CurrentPlayer, PlayerHand),
        getSubHand(CardSelected, PlayerHand, UpdatedHand),
        getBuildsFromState(State, Builds),
        tryIncrease(State, Builds, PlayerHand, UpdatedHand).

checkCardsPlayed(State, CardSelected, [], MoveType) :-
        MoveType = extend,
        getPlayNextFromState(State, CurrentPlayer),
        getCurrentPlayersHand(State, CurrentPlayer, PlayerHand),
        getSubHand(CardSelected, PlayerHand, UpdatedHand),
        getBuildsFromState(State, Builds),
        tryExtendBuild(State, Builds, PlayerHand, UpdatedHand).

checkCardsPlayed(State, CardSelected, [], MoveType) :-
        MoveType = build,
        getPlayNextFromState(State, CurrentPlayer),
        getCurrentPlayersHand(State, CurrentPlayer, PlayerHand),
        getSubHand(CardSelected, PlayerHand, UpdatedHand),
        getBuildsFromState(State, Builds),
        tryBuild(State, Builds, PlayerHand, UpdatedHand).
        
checkCardsPlayed(State, CardSelected, Hand, MoveType) :-
        MoveType = increase,
        [CardPlayed | Rest] = Hand,
        % isCaptureCard(State, CardSelected, CardPlayed, Hand, MoveType),
        assessCardPlayed(State, CardSelected, CardPlayed, Hand, MoveType),
        aiIncrease(State, CardSelected, CardPlayed, Rest).

checkCardsPlayed(State, CardSelected, Hand, MoveType) :-
        MoveType = extend,
        [CardPlayed | Rest] = Hand,
        % isCaptureCard(State, CardSelected, CardPlayed, Hand, MoveType),
        assessCardPlayed(State, CardSelected, CardPlayed, Hand, MoveType),
        aiExtendBuild(State, CardSelected, CardPlayed, Rest).

checkCardsPlayed(State, CardSelected, Hand, MoveType) :-
        MoveType = build,
        [CardPlayed | Rest] = Hand,
        % isCaptureCard(State, CardSelected, CardPlayed, Hand, MoveType),
        assessCardPlayed(State, CardSelected, CardPlayed, Hand, MoveType),
        aiBuild(State, CardSelected, CardPlayed, Rest).

/**
Clause Name: assessCardPlayed
Purpose: If Card selected is the same card being evaluated to play into a build, move on to the next card to play.
Parameters:
        State, List of variables involved in current game state.
        CardSelected, Card selected to sum build to for AI assessment.
        CardPlayed, Card selected to play into a build for AI assessment.
        Hand, Cards in player's hand.
        MoveType, Type of move currently being assessed by AI.
**/
assessCardPlayed(State, CardSelected, CardPlayed, Hand, MoveType) :-
        CardSelected = CardPlayed,
        getPlayNextFromState(State, CurrentPlayer),
        getCurrentPlayersHand(State, CurrentPlayer, PlayerHand),
        getBuildsFromState(State, Builds),
        getSubHand(CardSelected, PlayerHand, UpdatedHand),
        selectNewCardForAssessment(State, CardSelected, UpdatedHand, MoveType).

assessCardPlayed(_, CardSelected, CardPlayed, _, _) :-
        CardSelected \= CardPlayed.

/**
Clause Name: selectNewCardForAssessment
Purpose: If card selected was the same as card played, test next card for play.
Parameters:
        State, List of variables involved in current game state.
        Builds, List of builds on game table.
        Hand, List of cards left to test in player's hand.
        MoveType, Type of move currently being assessed by AI.
**/
selectNewCardForAssessment(State, CardSelected, Hand, increase) :-
        checkCardsPlayed(State, CardSelected, Hand, increase).

selectNewCardForAssessment(State, CardSelected, Hand, extend) :-
        checkCardsPlayed(State, CardSelected, Hand, extend).

selectNewCardForAssessment(State, CardSelected, Hand, build) :-
        checkCardsPlayed(State, CardSelected, Hand, build).


/**
Clause Name: getSubHand
Purpose: Finds a sublist of given hand after card is found.
Parameters:
        Card, Card being looked for to slice list at.
        Hand, List of cards being looked through.
        UpdatedHand, Slice of cards in hand after card is found.
**/
getSubHand(Card, Hand, UpdatedHand) :-
        [Card | Rest] = Hand,
        UpdatedHand = Rest.

getSubHand(Card, Hand, UpdatedHand) :-
        [_ | Rest] = Hand,
        getSubHand(Card, Rest, UpdatedHand).


/**
Clause Name: findMaxHeuristicOfList
Purpose: Finds the maximum value of a list as well as its index. (Used specifically for finding best heuristic value for capture)
Parameters:
        List, List of values to find max.
        MaxVal, Maximum value of list.
        OldMax, Keeps track of prior maximum value - updated as necessary.
        OldIndex, Keeps track of prior index of max value - updated as necessary.
        CurrentIndex, Current index to keep track of iteration through list.
        Index, Maximum index of list to be send out of clause.
**/
% Wrapper to call clause with max starting at 0.
findMaxHeuristicOfList([Element | Rest], MaxVal, Index):-
        findMaxHeuristicOfList(Rest , Element, 0, 0, MaxVal, Index).

findMaxHeuristicOfList([], OldMax, OldIndex, _, OldMax, OldIndex).

findMaxHeuristicOfList([Element | Rest], OldMax, _, CurrentIndex, MaxVal, Index):-
    Element > OldMax,
    NewCurrentIndex is CurrentIndex + 1,
    NewIndex is NewCurrentIndex,
    findMaxHeuristicOfList(Rest, Element, NewIndex, NewCurrentIndex, MaxVal, Index).

findMaxHeuristicOfList([Element | Rest], OldMax, OldIndex, CurrentIndex, MaxVal, Index):-
    Element =< OldMax,
    NewCurrentIndex is CurrentIndex + 1,
    findMaxHeuristicOfList(Rest, OldMax, OldIndex, NewCurrentIndex, MaxVal, Index).

/**
Clause Name: aiGetTableCardsForBuild
Purpose: Searches all possible subsets of cards on the table and finds a set of cards you can start a build with.
Parameters:
        CardSelected, Card selected to sum build to.
        CardPlayed, Card to be played into build.
        TableCards, List of cards on the table.
        FinalCardsSelected, U/I variable to send subset found out of clause.
**/
aiGetTableCardsForBuild(CardSelected, CardPlayed, TableCards, FinalCardsSelected) :-
        getAllSubsets(TableCards, SubsetList),
        removeCardFromList([], SubsetList, UpdatedList),
        getValue(CardSelected, SelectedValue),
        getSetValue([CardPlayed], 0, PlayedVal),
        findViableSubset(UpdatedList, SelectedValue, PlayedVal, _, FinalCardsSelected).

/**
Clause Name: aiExtendBuild
Purpose: AI build algo for extending to a multi-build
Parameters:
        State, list of variables involved in current game state.
        CardSelected, Card selected by AI to sum the build to.
        CardPlayed, Card selected by AI to play into a build.
        RestOfTestHand, Rest of hand that needs to be tested by AI.
**/
aiExtendBuild(State, CardSelected, CardPlayed, RestOfTestHand) :-
        getValue(CardSelected, SelectedValue),
        getValue(CardPlayed, PlayedVal),
        aiCheckValuesSelected(State, CardSelected, SelectedValue, PlayedVal, RestOfTestHand, extend),
        getBuildsFromState(State, Builds),
        Builds \= [],
        getPlayNextFromState(State, CurrentPlayer),
        getBuildOwnersFromState(State, BuildOwners),
        extendingBuild(CardSelected, CurrentPlayer, Builds, BuildOwners, BuildFound),
        checkBuildFound(State, CardSelected, RestOfTestHand, BuildFound, extend),
        getTableCardsFromState(State, TableCards),
        aiGetTableCardsForBuild(CardSelected, CardPlayed, TableCards, CardsSelectedForBuild),
        checkIfBuildEmpty(State, CardSelected, RestOfTestHand, CardsSelectedForBuild, extend),
        append(CardsSelectedForBuild, [CardPlayed], BuildList),
        getBuildValue([BuildList], BuildVal),
        aiValidateBuildCreated(State, CardSelected, RestOfTestHand, BuildVal, SelectedValue, extend),
        humanCheckMultiBuild(State, CurrentPlayer, [BuildFound, [BuildList]]),
        updateBuildList(BuildFound, BuildList, Builds, _, BuildsAfterMove),
        getCurrentPlayersHand(State, CurrentPlayer, PlayerHand),
        removeCardFromList(CardPlayed, PlayerHand, PlayerHandAfterMove),
        getTableCardsFromState(State, TableCards),
        removeCardsFromList(BuildList, TableCards, TableCardsAfterMove),
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanScoreFromState(State, HumanScore),
        getHumanPileFromState(State, HumanPile),
        getComputerPileFromState(State, ComputerPile),
        getComputerScoreFromState(State, ComputerScore),
        getTableCardsFromState(State, TableCards),
        getPlayerHands(State, CurrentPlayer, PlayerHandAfterMove, HumanHand, ComputerHand),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        getLastCapturerFromState(State, LastCapturer),        
        NewState = [RoundNum, ComputerScore, ComputerHand, ComputerPile, HumanScore, HumanHand, HumanPile, TableCardsAfterMove, BuildsAfterMove, BuildOwners, LastCapturer, GameDeck, NextPlayer],
        assessRound(NewState).

/**
Clause Name: aiBuild
Purpose: AI Build algo for single build creation.
Parameters:
        State, list of variables involved in current game state.
        CardSelected, Card selected by AI to sum the build to.
        CardPlayed, Card selected by AI to play into a build.
        RestOfTestHand, Rest of hand that needs to be tested by AI.
**/
aiBuild(State, CardSelected, CardPlayed, RestOfTestHand) :-
        getPlayNextFromState(State, CurrentPlayer),
        getBuildsFromState(State, Builds),
        getValue(CardSelected, SelectedValue),
        getSetValue([CardPlayed], 0, PlayedVal),
        aiCheckValuesSelected(State, CardSelected, SelectedValue, PlayedVal, RestOfTestHand, build),
        getTableCardsFromState(State, TableCards),
        aiGetTableCardsForBuild(CardSelected, CardPlayed, TableCards, CardsSelected),
        checkIfBuildEmpty(State, CardSelected, RestOfTestHand, CardsSelected, build),
        append(CardsSelected, [CardPlayed], BuildList),
        getBuildValue([BuildList], BuildVal),
        aiValidateBuildCreated(State, CardSelected, RestOfTestHand, BuildVal, SelectedValue, build),
        humanCheckBuild(State, CurrentPlayer, [BuildList]),
        append(Builds, [[BuildList]], BuildsAfterMove),
        getCurrentPlayersHand(State, CurrentPlayer, PlayerHand),
        removeCardFromList(CardPlayed, PlayerHand, PlayerHandAfterMove),
        getTableCardsFromState(State, TableCards),
        removeCardsFromList(BuildList, TableCards, TableCardsAfterMove),
        getBuildOwnersFromState(State, BuildOwners),
        append(BuildOwners, [CurrentPlayer], NewBuildOwners),
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanScoreFromState(State, HumanScore),
        getHumanPileFromState(State, HumanPile),
        getComputerPileFromState(State, ComputerPile),
        getComputerScoreFromState(State, ComputerScore),
        getTableCardsFromState(State, TableCards),
        getPlayerHands(State, CurrentPlayer, PlayerHandAfterMove, HumanHand, ComputerHand),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        getLastCapturerFromState(State, LastCapturer),        
        NewState = [RoundNum, ComputerScore, ComputerHand, ComputerPile, HumanScore, HumanHand, HumanPile, TableCardsAfterMove, BuildsAfterMove, NewBuildOwners, LastCapturer, GameDeck, NextPlayer],
        assessRound(NewState).

        /**
Clause Name: checkBuildFound
Purpose: Checks build found for extension and makes sure it is viable.
Parameters:
        State, List of variables involved in current game state.
        CardSelected, Card selected by AI to sum the build to.
        RestOfTestHand, Rest of hand to be tested by AI.
        BuildFound, Build found to extend.
        MoveType, Type of move being assessed by the AI.
**/
checkBuildFound(State, CardSelected, RestOfTestHand, BuildFound, MoveType) :-
        getBuildValue(BuildFound, BuildVal),
        getValue(CardSelected, SelectedValue),
        checkBuildValue(SelectedValue, BuildVal, BuildFound, BuildAfterCheck),
        checkIfBuildEmpty(State, CardSelected, RestOfTestHand, BuildAfterCheck, MoveType).

/**
Clause Name: checkIfBuildEmpty
Purpose: Checks to see if build found if empty, if so: AI moves on to evaluate next card in hand to play.
Parameters:
        State, List of variables involved in current game state.
        CardSelected, Card selected by AI to sum the build to.
        RestOfTestHand, Rest of hand to be tested by AI.
        BuildFound, Build found to extend.
        MoveType, Type of move being assessed by the AI.
**/
checkIfBuildEmpty(State, CardSelected, RestOfTestHand, Build, MoveType) :-
        Build = [],
        checkCardsPlayed(State, CardSelected, RestOfTestHand, MoveType).
checkIfBuildEmpty(_, _, _, _, _).

/**
Clause Name: humanCheckBuild
Purpose: If player getting help is human, ask them if they want to make the recommended move.
Parameters:    
        State, List of current variables in game state.
        CurrentPlayer, Player currently making move.
        BuildToIncrease, Build selected to increase by AI.
**/
humanCheckMultiBuild(_, CurrentPlayer, Build) :- 
        CurrentPlayer = computer,
        write('Computer creating build: '), write('[ '), printBuilds(Build), write('] '), nl.

humanCheckMultiBuild(State, CurrentPlayer, Build) :-
        CurrentPlayer = human,
        write('Are you sure you want to create this build(y/n): '), write('[ '), printBuilds(Build), write('] '),
        read(Input),
        assessAIConfirmation(State, Input).

/**
Clause Name: humanCheckBuild
Purpose: If player getting help is human, ask them if they want to make the recommended move.
Parameters:    
        State, List of current variables in game state.
        CurrentPlayer, Player currently making move.
        BuildToIncrease, Build selected to increase by AI.
**/
humanCheckBuild(_, CurrentPlayer, Build) :- 
        CurrentPlayer = computer,
        write('Computer creating build: '), printBuild(Build), nl.

humanCheckBuild(State, CurrentPlayer, Build) :-
        CurrentPlayer = human,
        write('Are you sure you want to create this build(y/n): '), printBuild(Build),
        read(Input),
        assessAIConfirmation(State, Input).

/**
Clause Name: aiValidateBuildCreated
Purpose: Check to make sure build created by AI has the correct values.
Parameters: 
        State, List of variables involved in current game state.
        CardSelected, Card selected to sum build to.
        RestOfTestHand, Remaining hand that AI needs to test for each move.
        BuildVal, Value that build sums to.
        SelectedValue, Value of card selected to sum build to.
        MoveType, Type of move that AI is currently checking.
**/
aiValidateBuildCreated(_, _, _, BuildVal, SelectedValue, _) :-
        BuildVal = SelectedValue.

aiValidateBuildCreated(State, CardSelected, RestOfTestHand, BuildVal, SelectedValue, MoveType) :-
        BuildVal \= SelectedValue,
        checkCardsPlayed(State, CardSelected, RestOfTestHand, MoveType).

/**
Clause Name: aiIncrease
Purpose: Check to see if AI can increase and claim a build.
Parameters:
        State, list of variables used in game state.
        CardSelected, Card selected to sum increased build to.
        CardPlayed, Card to play into build.
        RestOfTestHand, Rest of cards in hand that AI has yet to test.
**/
aiIncrease(State, CardSelected, CardPlayed, RestOfTestHand) :-
        getBuildsFromState(State, Builds),
        getPlayNextFromState(State, CurrentPlayer),
        getValue(CardSelected, SelectedValue),
        getValue(CardPlayed, PlayedVal),
        aiCheckValuesSelected(State, CardSelected, SelectedValue, PlayedVal, RestOfTestHand, increase),
        aiGetBuildSelection(State, CardSelected, RestOfTestHand, CurrentPlayer, SelectedValue, PlayedVal, Builds, BuildToIncrease),
        write('Found build to increase: '), printBuild(BuildToIncrease), nl,
        getBuildOwnersFromState(State, BuildOwners),
        aiValidateBuild(State, CardSelected, RestOfTestHand, BuildToIncrease, Builds, BuildOwners, CurrentPlayer),
        write('Build belongs to other player!'), nl,
        indexOf(Builds, BuildToIncrease, IndexOfBuild),
        humanCheckIncrease(State, CurrentPlayer, BuildToIncrease),
        increaseBuild(CardPlayed, BuildToIncrease, IndexOfBuild, CurrentPlayer, BuildOwners, IncreasedBuild, NewBuildOwners),
        write('New build of: '), printBuild(IncreasedBuild),
        write('has been created and is now owned by: '), write(CurrentPlayer), nl,
        replaceElement(IndexOfBuild, Builds, IncreasedBuild, BuildsAfterMove),
        getCurrentPlayersHand(State, CurrentPlayer, PlayerHand),
        removeCardFromList(CardPlayed, PlayerHand, PlayerHandAfterMove),
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanScoreFromState(State, HumanScore),
        getHumanPileFromState(State, HumanPile),
        getComputerPileFromState(State, ComputerPile),
        getComputerScoreFromState(State, ComputerScore),
        getTableCardsFromState(State, TableCards),
        getPlayerHands(State, CurrentPlayer, PlayerHandAfterMove, HumanHand, ComputerHand),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        getLastCapturerFromState(State, LastCapturer),
        NewState = [RoundNum, ComputerScore, ComputerHand, ComputerPile, HumanScore, HumanHand, HumanPile, TableCards, BuildsAfterMove, NewBuildOwners, LastCapturer, GameDeck, NextPlayer],
        assessRound(NewState).

/**
Clause Name: humanCheckIncrease
Purpose: If player getting help is human, ask them if they want to make the recommended move.
Parameters:    
        State, List of current variables in game state.
        CurrentPlayer, Player currently making move.
        BuildToIncrease, Build selected to increase by AI.
**/
humanCheckIncrease(_, CurrentPlayer, _) :- CurrentPlayer = computer.

humanCheckIncrease(State, CurrentPlayer, BuildToIncrease) :-
        CurrentPlayer = human,
        write('Are you sure you want to increase this build(y/n): '), printBuild(BuildToIncrease),
        read(Input),
        assessAIConfirmation(State, Input).

/**
Clause Name: assessAIConfirmation
Purpose: Checks the input provided by user for confirming recommended move.
Parameters:
        State, List of variables in current game state.
        Input, Input provded by user.
**/
assessAIConfirmation(_, Input) :-
        Input = y.

assessAIConfirmation(State, Input) :-
        Input = n,
        write('You have selected not to make AI recommended move. Restarting turn.'), nl,
        assessRound(State).

assessAIConfirmation(State, _) :-
        write('Invalid input. Try again'),
        assessRound(State).

/**
Clause Name: aiCheckValuesSelected
Purpose: Check values of cards and builds to see if increase move is valid.
Parameters:
        State, List of variables used in current game state.
        CardSelected, Card selected to sum build to.
        SelectedValue, Value of card selected.
        PlayedVal, Value of card played.
        RestOfTestHand, Rest of player's hand being assessed by AI.
**/
aiCheckValuesSelected(_, _, SelectedValue, PlayedVal, _, _) :-
        SelectedValue > PlayedVal.

aiCheckValuesSelected(State, CardSelected, SelectedValue, PlayedVal, RestOfTestHand, MoveType) :-
        SelectedValue = PlayedVal,
        checkCardsPlayed(State, CardSelected, RestOfTestHand, MoveType).

aiCheckValuesSelected(State, CardSelected, SelectedValue, PlayedVal, RestOfTestHand, MoveType) :-
        SelectedValue < PlayedVal,
        checkCardsPlayed(State, CardSelected, RestOfTestHand, MoveType).

/**
Clause Name: aiGetBuildSelection
Purpose: Find build to increase.
Parameters:
        State, List of variables used in current game state.
        CardSelected, Card selected to sum build to.
        RestOfTestHand, Rest of player's hand being assessed by AI.
        Builds, List of current builds on game table.
        SelectedValue, Value of card selected.
        PlayedVal, Value of card played.
        BuildIn, Used to pass builds around clause.
        BuildToIncrease, Used to send build found out of clause.
**/
aiGetBuildSelection(State, CardSelected, RestOfTestHand, CurrentPlayer, SelectedValue, PlayedVal, BuildsBeforeMove, BuildToIncrease) :-      
        checkAllBuilds(State, CardSelected, RestOfTestHand, BuildsBeforeMove, SelectedValue, PlayedVal, [], BuildToIncrease).

/**
Clause Name: checkAllBuilds
Purpose: Checks all current builds to find one to increase.
Parameters:
        State, List of variables used in current game state.
        CardSelected, Card selected to sum build to.
        RestOfTestHand, Rest of player's hand being assessed by AI.
        Builds, List of current builds on game table.
        SelectedValue, Value of card selected.
        PlayedVal, Value of card played.
        BuildIn, Used to pass builds around clause.
        BuildToIncrease, Used to send build found out of clause.
**/
checkAllBuilds(State, CardSelected, RestOfTestHand, [], _, _, [], _) :- checkCardsPlayed(State, CardSelected, RestOfTestHand, increase).

checkAllBuilds(_, _, _, [], _, _, BuildIn, BuildToIncrease) :- BuildToIncrease = BuildIn.

checkAllBuilds(_, _, _, _, _, _, BuildIn, BuildToIncrease) :-
        BuildIn \= [],
        BuildToIncrease = BuildIn.

checkAllBuilds(State, CardSelected, RestOfTestHand, Builds, SelectedValue, PlayedVal, BuildIn, BuildToIncrease) :-
        [Build | Rest] = Builds,
        getBuildValue(Build, BuildVal),
        aiAssessBuildValue(SelectedValue, PlayedVal, BuildVal, Build, BuildFound),
        checkAllBuilds(State, CardSelected, RestOfTestHand, Rest, SelectedValue, PlayedVal, BuildFound, BuildToIncrease).

/**
Clause Name: aiAssessBuildValue
Purpose: Used by AI to see if cards selected can increase the build.
Parameters:
        SelectedValue, Value of card selected.
        PlayedVal, Value of card played.
        BuildVal, Value that build sums to.
        BuildToAssess, Build that is being assessed for increase.
        BuildFound, If build can be increased, this variable will send it out of the clause. Else it will send an empty list.
**/
aiAssessBuildValue(SelectedValue, PlayedVal, BuildVal, BuildToAssess, BuildFound) :-
        SelectedValue is PlayedVal + BuildVal,
        BuildFound = BuildToAssess.

aiAssessBuildValue(_, _, _, _, BuildFound) :- BuildFound = [].

/**
Clause Name: aiValidateBuild
Purpose: AI checks to make sure build is valid for increase move.
Parameters:
        State, List of variables used in current game state.
        CardSelected, Card selected to sum build to.
        RestOfTestHand, Rest of player's hand being assessed by AI.
        BuildSelected, Build selected for assessment of increase.
        CurrentBuilds, Builds currently on table.
        BuildOwners, Current list of build owners.
        CurrentPlayer, Player currently making move.
**/
aiValidateBuild(State, CardSelected, RestOfTestHand, BuildSelected, CurrentBuilds, BuildOwners, CurrentPlayer) :-
        aiCheckIsMultiBuild(State, CardSelected, RestOfTestHand, BuildSelected),
        indexOf(CurrentBuilds, BuildSelected, Index),
        nth0(Index, BuildOwners, Owner),
        aiCheckIsOpponentsBuild(State, CardSelected, RestOfTestHand, CurrentPlayer, Owner).

/**
Clause Name: aiCheckIsMultiBuild
Purpose: AI checks to see if a build is a multi-build; if it is, AI goes to check the next card in hand.
**/
aiCheckIsMultiBuild(_, _, _, BuildSelected) :-
        length(BuildSelected, 1).

aiCheckIsMultiBuild(State, CardSelected, RestOfTestHand, _) :-
        checkCardsPlayed(State, CardSelected, RestOfTestHand, increase).

/**
Clause Name: aiCheckIsOpponentsBuild
Purpose: Used by AI to check if build selected belongs to opponent. If true, continues to check the next card in hand.
Parameters:
        State, List of variables involved in current game state.
        CardSelected, Card selected to sum build to.
        CurrentPlayer, Player currently making move.
        Owner, Player that owns the build selected.
**/
aiCheckIsOpponentsBuild(_, _, _, CurrentPlayer, Owner) :-
        CurrentPlayer \= Owner.

aiCheckIsOpponentsBuild(State, CardSelected, RestOfTestHand, _, _) :-
        checkCardsPlayed(State, CardSelected, RestOfTestHand, increase).

/**
Clause Name: aiCapture
Purpose: Make Capture move recommended by AI.
Parameters:
        State, List of variables involved in current game state.
        TableCards, list of cards on game table.
        Builds, List of builds currently on table.
        CardPlayed, Card played to capture with.
**/
aiCapture(State, TableCards, Builds, CardPlayed) :-
        getCapturableCards(TableCards, CardPlayed, _, CapturableLooseCards),
        getPlayNextFromState(State, CurrentPlayer),
        removeCardsFromList(CapturableLooseCards, TableCards, TableCardsAfterSameVal),
        getCapturableBuilds(CardPlayed, Builds, _, CapturableBuilds),
        getCapturableSetsForAI(CardPlayed, TableCardsAfterSameVal, CapturableSets),
        getCurrentPlayersHand(State, CurrentPlayer, PlayerHand),
        capturerIsHuman(State, PlayerHand, CurrentPlayer, CapturableLooseCards, CapturableBuilds, CapturableBuildsAfterPrompt, CapturableSets, CapturableSetsAfterPrompt),
        % need to update model
        getBuildOwnersFromState(State, BuildOwners),
        removeBuildOwners(CapturableBuildsAfterPrompt, Builds, BuildOwners, NewBuildOwners),
        removeSetsFromList(CapturableBuildsAfterPrompt, Builds, BuildsAfterMove),
        flattenList(CapturableSets, _, CapturableSetsAsList),
        removeSetsFromList(CapturableSetsAsList, TableCardsAfterSameVal, TableCardsAfterMove),
        getCurrentPlayersPile(State, CurrentPlayer, PlayerPile),
        append(PlayerPile, [CardPlayed], PlayerPileWithCaptureCard),
        flattenList(CapturableBuildsAfterPrompt, _, BuildCardsCaptured),
        flattenList(BuildCardsCaptured, _, FlatBuildsCaptured),
        append(PlayerPileWithCaptureCard, FlatBuildsCaptured, PlayerPileWithBuilds),
        append(PlayerPileWithBuilds, CapturableLooseCards, PlayerPileWithSameVal),
        append(PlayerPileWithSameVal, CapturableSetsAsList, PlayerPileWithSets),
        removeCardFromList(CardPlayed, PlayerHand, PlayerHandAfterMove),
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanScoreFromState(State, HumanScore),
        getComputerScoreFromState(State, ComputerScore),
        getPlayerHands(State, CurrentPlayer, PlayerHandAfterMove, HumanHand, ComputerHand),
        getPlayerPiles(State, CurrentPlayer,  PlayerPileWithSets, HumanPile, ComputerPile),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        NewState = [RoundNum, ComputerScore, ComputerHand, ComputerPile, HumanScore, HumanHand, HumanPile, TableCardsAfterMove, BuildsAfterMove, NewBuildOwners, CurrentPlayer, GameDeck, NextPlayer], 
        assessRound(NewState).

/**
Clause Name: capturerIsHuman
Purpose: If AI capturer is human, prompt them for each step of the capture recommendations.
Parameters:
        State, List of variables involved in current game state.
        PlayerHand, List of cards in player's hand.
        CapturableLooseCards, Capturable same val cards on the table.
        CapturableBuilds, List of capturable builds on the table.
        CapturableBuildsAfterPrompt, U/I variable to send back list of builds after prompt ([] if user does not want to capture, shared with CapturableBuilds otherwise).
        CapturableSets, List of capturable sets on the table.
        CapturableSetsAfterPrompt, U/I variable to send back list of capturable sets after prompt([] if user does not want to capture, shared with CapturableSets otherwise).
**/
capturerIsHuman(State, PlayerHand, CurrentPlayer, CapturableLooseCards, CapturableBuilds, CapturableBuildsAfterPrompt, CapturableSets, CapturableSetsAfterPrompt) :-
        CurrentPlayer = human,
        promptSameFaceCapture(State, CapturableLooseCards),
        promptBuildCapture(State, PlayerHand, CapturableBuilds, CapturableBuildsAfterPrompt),
        allowSetCapture(State, CapturableSets, CapturableSetsAfterPrompt),
        checkCapturableCards(State, CapturableLooseCards, CapturableBuildsAfterPrompt, CapturableSetsAfterPrompt).


capturerIsHuman(_, _, computer, CapturableLooseCards, CapturableBuilds, CapturableBuilds, CapturableSets, CapturableSets) :-
        write('Computer will capture same face card(s): '), printCards(CapturableLooseCards), nl,
        write('Builds: '), printBuilds(CapturableBuilds), nl,
        write('and Sets: '), printSets(CapturableSets), nl.


/**
Clause Name: allowSetCapture
Purpose: Checks to see if human wants to capture AI recommended sets.
Parameters:
        State, List of variables involved in current game state.
        CapturableSets, List of sets that are recommended for capture by AI.
        CapturableSetsAfter, U/I variable that will either share value with CapturableSets or be set to [] if user selects not to capture.
**/
allowSetCapture(State, [], []).

allowSetCapture(State, CapturableSets, CapturableSetsAfter) :-
        write('Do you want to capture the following sets? (y/n): '),
        printSets(CapturableSets),
        read(Input),
        assessSetCaptureInput(State, Input, CapturableSets, CapturableSetsAfter).

/**
Clause Name: assessSetCaptureInput
Purpose: Assesses user input in regard to set capture for AI.
Parameters:
        State, List of variables involved in current game state.
        Input, User input.
        CapturableSets, Sets recommended for capture by AI.
        CapturableSetsAfter, U/I variable that will either share value with CapturableSets or be set to [] if user selects not to capture.
**/
assessSetCaptureInput(_, Input, CapturableSets, CapturableSetsAfter) :-
        Input = y,
        CapturableSetsAfter = CapturableSets.

assessSetCaptureInput(_, n, _, CapturableSetsAfter) :-
        CapturableSetsAfter = [].

assessSetCaptureInput(State, _, _, _) :-
        write('Invalid input. Try again.'), nl,
        assessRound(State).

/**
Clause Name: checkCapturableCards
Purpose: Checks capturable cards lists after prompt, if they are all empty. Restart move.
Parameters:
    State, List of variables involved in current game state.
    CapturableLooseCards, List of loose same face cards that can be captured.
    CapturableBuilds, List of builds that can be captured.
    CapturableSets, list of sets that can be captured.
**/
checkCapturableCards(State, [], [], []) :-
        write('No cards selected for capture. Invalid move, try again.'), nl,
        assessRound(State).

checkCapturableCards(State, _, _, _).

