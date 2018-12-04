/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************
* Game Move Logic          *                  
***************************/

/**
Clause Name: getMove
Purpose: Get move selection from user.
Parameters:
    State, List containing current game state.
    NextPlayer, Player who is currently making the move.
    TableCardsBeforeMove, List of table cards before a move is made.
    HumanHandBeforeMove, List of cards in human's hand before move is made.
    ComputerHandBeforeMove, List of cards in computer's hand before move is made.
    HumanHand
**/
getMove(State, BuildsBeforeMove, BuildsAfterMove, NextPlayer, TableCardsBeforeMove, HumanHandBeforeMove, ComputerHandBeforeMove, HumanHandAfterMove, ComputerHandAfterMove, TableCardsAfterMove, HumanPileAfterMove, ComputerPileAfterMove) :-
        getPlayNextFromState(State, CurrentPlayer),
        CurrentPlayer = human,
        write('What move would you like to make?'), nl,
        write('(capture, build, extend, increase, trail, help, save, deck, or exit): '),
        read(MoveInput),
        getHumanPileFromState(State, HumanPileBeforeMove),
        getComputerPileFromState(State, ComputerPileAfterMove),
        makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove).

% Computer move
getMove(State, BuildsBeforeMove, BuildsAfterMove, NextPlayer, TableCardsBeforeMove, HumanHandBeforeMove, ComputerHandBeforeMove, HumanHandAfterMove, ComputerHandAfterMove, TableCardsAfterMove, HumanPileAfterMove, ComputerPileAfterMove) :- 
        getPlayNextFromState(State, CurrentPlayer),
        CurrentPlayer = computer,
        getHelp(State, BuildsBeforeMove, TableCardsBeforeMove, ComputerHandBeforeMove).

getHelp(State, Builds, TableCards, PlayerHand) :-
        % Check for increase
        tryIncrease(State, Builds, PlayerHand, PlayerHand).

/**
Clause Name: makeMove
Purpose: Make move given user's move selection.
Parameters:
    MoveInput, Move selected by player
    TableCardsBeforeMove, List of cards on table before move is made.
    TableCardsAfterMove, Variable to be instantiated to list of cards on table after move is made.
    HumanHandBeforeMove, List of cards in player's hand.
    HumanHandAfterMove, Variable to be instantiated to list of cards in hand after move is made.
**/
makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput = trail,
        write('Select the idx of card in your hand: '),
        printCards(HumanHandBeforeMove),
        read(Input),
        write('Human making move.'), nl,
        selectCard(HumanHandBeforeMove, Card, Input),
        trail(State, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove).

makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput = capture,
        write('Select the idx of card in your hand: '),
        printCards(HumanHandBeforeMove),
        read(Input),
        write('Human making move.'), nl,
        selectCard(HumanHandBeforeMove, Card, Input), 
        capture(State, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove, BuildsBeforeMove, BuildsAfterMove).

makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput = extend,
        write('Select the card you want to sum the multi-build to: '),
        printCards(HumanHandBeforeMove),
        read(Input1),
        write('Select the card you want to play into a build: '),
        printCards(HumanHandBeforeMove),
        read(Input2),
        selectCard(HumanHandBeforeMove, CardSelected, Input1),
        selectCard(HumanHandBeforeMove, CardPlayed, Input2),
        extendBuild(State, CardSelected, CardPlayed, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, BuildsBeforeMove, BuildsAfterMove).

makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput = build,
        write('Select the card you want to sum the build to: '),
        printCards(HumanHandBeforeMove),
        read(Input1),
        write('Select the card you want to play into a build: '),
        printCards(HumanHandBeforeMove),
        read(Input2),
        selectCard(HumanHandBeforeMove, CardSelected, Input1),
        selectCard(HumanHandBeforeMove, CardPlayed, Input2),
        build(State, CardSelected, CardPlayed, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, BuildsBeforeMove, BuildsAfterMove).

makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput = increase,
        write('Select the card you want to sum the increased build to: '),
        printCards(HumanHandBeforeMove),
        read(Input1),
        write('Select the card you want to play into the build: '),
        printCards(HumanHandBeforeMove),
        read(Input2),
        selectCard(HumanHandBeforeMove, CardSelected, Input1),
        selectCard(HumanHandBeforeMove, CardPlayed, Input2),
        increase(State, CardSelected, CardPlayed, TableCardsBeforeMove, HumanHandBeforeMove, BuildsBeforeMove).

makeMove(State, BuildsBeforeMove, _, MoveInput, _, TableCardsBeforeMove, _, HumanHandBeforeMove, _, _, _) :-
        MoveInput = help,
        getHelp(State, BuildsBeforeMove, TableCardsBeforeMove, HumanHandBeforeMove).

makeMove(State, _, _, MoveInput, _, _, _, _, _, _, _) :-
        MoveInput = deck,
        getDeckFromState(State, GameDeck),
        write('Current deck: '), printCards(GameDeck), nl,
        getLengthOfList(GameDeck, DeckSize),
        write('Cards left: '), write(DeckSize), nl,
        assessRound(State).


makeMove(State, _, _, MoveInput, _, _, _, _, _, _, _) :-
        MoveInput = save,
        getSaveFileName(SaveFileName),
        open(SaveFileName, write, SAVEFILE),
        write(SAVEFILE, State),
        write(SAVEFILE, '.'),
        close(SAVEFILE),
        write('Game saved. Exiting now.'), nl,
        halt().

makeMove(_, _, _, MoveInput, _, _, _, _, _, _, _) :-
        MoveInput = exit,
        write('Thanks for playing! Exiting game.'), nl,
        halt().

makeMove(State, _, _, _, _, _, _, _, _, _, _) :-
        write('Invalid move input. Try again'), nl,
        assessRound(State).

/**
Clause Name: trail
Purpose: Trail a card from player's hand and add it to the table.
Parameters:
    Card, Variable representing card to be played.
    TableCardsBeforeMove, List of cards on table before move is made.
    TableCardsAfterMove, Variable to be instantiated to list of cards on table after card is played.
    HumanHandBeforeMove/ComputerHandBeforeMove, List of cards in player's hand.
    HumanHandAfterMove/ComputerHandAfterMove, Variable to be instantiated to list of cards in hand after card is played.
**/
trail(State, Card, TableCardsBeforeMove, TableCardsAfterMove, HandBeforeMove, HandAfterMove) :- 
        getBuildOwnersFromState(State, BuildOwners),
        getPlayNextFromState(State, CurrentPlayer),
        validateTrail(State, Card, TableCardsBeforeMove, BuildOwners, CurrentPlayer),
        append(TableCardsBeforeMove, [Card], TableCardsAfterMove),
        removeCardFromList(Card, HandBeforeMove, HandAfterMove),
        write('Player has selected to trail:'), printCards([Card]), nl,     
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanScoreFromState(State, HumanScore),
        getHumanPileFromState(State, HumanPile),
        getComputerScoreFromState(State, ComputerScore),
        getComputerPileFromState(State, ComputerPile),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        getLastCapturerFromState(State, LastCapturer),
        getPlayerHands(State, CurrentPlayer, HandAfterMove, HumanHand, ComputerHand),
        getBuildsFromState(State, Builds),
        NewState = [RoundNum, ComputerScore, ComputerHand, ComputerPile, HumanScore, HumanHand, HumanPile, TableCardsAfterMove, Builds, BuildOwners, LastCapturer, GameDeck, NextPlayer],
        assessRound(NewState).

/**
Clause Name: build
Purpose: Make a build move.
Paramaters:
    CardSelected, Card selected as the capture card for build.
    CardPlayed, Card selected to be played into the build from hand.
    TableCardsBeforeMove, List of cards on the table before a move is made.
    TableCardsAfterMove, Uninstantiated list of cards on the table after the move is made.
    HumanHandBeforeMove, List of cards in the human player's hand.
    HumanHandAfterMove, Uninstantiated list of cards in human player's hand after move is made.
    HumanPileBeforeMove, List of cards in human player's pile.
    HumanPileAfterMove, Uninstantiated list of cards in human player's pile after move is made.
**/
% Extending Build to Multi-build:
extendBuild(State, CardSelected, CardPlayed, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, BuildsBeforeMove, BuildsAfterMove) :-
        preliminaryCheck(State, BuildsBeforeMove),
        getPlayNextFromState(State, CurrentPlayer),
        getBuildOwnersFromState(State, BuildOwners),
        extendingBuild(CardSelected, CurrentPlayer, BuildsBeforeMove, BuildOwners, BuildFound),
        checkBuildFound(State, BuildFound),
        write('Player has selected to extend this build: '), printBuilds([BuildFound]),
        write('to a multiple build by playing card: '), printCards([CardPlayed]), nl,
        aiGetTableCardsForBuild(CardSelected, CardPlayed, TableCardsBeforeMove, FinalCardsSelected),
        append(FinalCardsSelected, [CardPlayed], BuildCardList),
        getBuildValue([BuildCardList], BuildVal),
        validateBuildCreated(State, BuildVal, SelectedValue),
        humanCheckMultiBuild(State, CurrentPlayer, [BuildFound, [BuildCardList]]),
        write('Creating build of: [ '), printBuilds([BuildFound, [BuildCardList]]), write(']'), nl,
        % update model
        updateBuildList(BuildFound, BuildCardList, BuildsBeforeMove, BuildsIn, BuildsAfterMove),
        removeCardFromList(CardPlayed, HumanHandBeforeMove, HumanHandAfterMove),
        removeCardsFromList(BuildCardList, TableCardsBeforeMove, TableCardsAfterMove),
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanScoreFromState(State, HumanScore),
        getHumanPileFromState(State, HumanPile),
        getComputerScoreFromState(State, ComputerScore),
        getComputerHandFromState(State, ComputerHand),
        getComputerPileFromState(State, ComputerPile),
        getLastCapturerFromState(State, LastCapturer),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        NewState = [RoundNum, ComputerScore, ComputerHand, ComputerPile, HumanScore, HumanHandAfterMove, HumanPile, TableCardsAfterMove, BuildsAfterMove, BuildOwners, LastCapturer, GameDeck, NextPlayer],
        assessRound(NewState).

/**
Clause Name: preliminaryCheck
Purpose: Check to make sure there exists at least one build to extend, restarts turn if builds = [].
Parameters:
        State, list of variables involved in current game state.
        Builds, List of builds currently on the table.
**/
preliminaryCheck(State, Builds) :-
        Builds = [],
        write('No current builds on the table, cannot extend. Try again'), nl,
        assessRound(State).

preliminaryCheck(_, _).

/**
Clause Name: checkBuildFound
Purpose: If BuildFound for extension is [], print error and restart turn. Else continue.
Parameters:
        State, List of variables involved in current game state.
        BuildFound, Build found for extension.
**/
checkBuildFound(State, BuildFound) :-
        BuildFound = [],
        write('No builds can be extended. Try again'), nl,
        assessRound(State).

checkBuildFound(_, _).


% Creating new build:  
build(State, CardSelected, CardPlayed, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, BuildsBeforeMove, BuildsAfterMove) :-
        getValue(CardSelected, SelectedValue),
        sameValBuildsExist(State, SelectedValue, BuildsBeforeMove),
        getValue(CardPlayed, PlayedValue),
        aiGetTableCardsForBuild(CardSelected, CardPlayed, TableCardsBeforeMove, FinalCardsSelected),
        append(FinalCardsSelected, [CardPlayed], BuildCardList),
        getBuildValue([BuildCardList], BuildVal),
        validateBuildCreated(State, BuildVal, SelectedValue),
        humanCheckBuild(State, CurrentPlayer, [BuildCardList]),
        write('Creating build of: [ '), printCards(BuildCardList), write(']'), nl,
        removeCardFromList(CardPlayed, HumanHandBeforeMove, HumanHandAfterMove),
        removeCardsFromList(BuildCardList, TableCardsBeforeMove, TableCardsAfterMove),
        append(BuildsBeforeMove, [[BuildCardList]], BuildsAfterMove),
        getBuildOwnersFromState(State, BuildOwners),
        getPlayNextFromState(State, CurrentPlayer),
        append(BuildOwners, [CurrentPlayer], NewBuildOwners),
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanScoreFromState(State, HumanScore),
        getHumanPileFromState(State, HumanPile),
        getComputerScoreFromState(State, ComputerScore),
        getComputerHandFromState(State, ComputerHand),
        getComputerPileFromState(State, ComputerPile),
        getLastCapturerFromState(State, LastCapturer),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        NewState = [RoundNum, ComputerScore, ComputerHand, ComputerPile, HumanScore, HumanHandAfterMove, HumanPile, TableCardsAfterMove, BuildsAfterMove, NewBuildOwners, LastCapturer, GameDeck, NextPlayer],
        assessRound(NewState).

/**
Clause Name: sameValBuildsExist
Purpose: Tries to find a build with the same value as card selected, if found. Warn user that they should extend this build and restart turn.
Parameters:
        State, List of variables involved in current game state.
        BuildVal, Value of build in question.
        SelectedValue, Value of card selected to sum new build to.
**/
sameValBuildsExist(State, SelectedValue, Builds) :-
        [Build | Rest] = Builds,
        getBuildValue([Build], BuildVal),
        checkIfSameValue(State, BuildVal, SelectedValue),
        sameValBuildsExist(State, SelectedValue, Rest).

/**
Clause Name: checkIfSameValue
Purpose: Checks to see if Build value is the same as selected value. If true, restarts turn and tells user to extend the build.
Parameters:
        State, List of variables involved in current game state.
        BuildVal, Value of build in question.
        SelectedValue, Value of card selected to sum new build to.
**/
checkIfSameValue(State, BuildVal, SelectedValue) :-
        BuildVal = SelectedValue,
        write('Build with this value already exists. Must select to extend it. Try again.'), nl,
        assessRound(State).

checkIfSameValue(_, _, _).


/**
Clause Name: extendingBuild
Purpose: Checks to see if you have a build to extend to a multi-build.
Parameters:
        CardSelected, Card that build is summing to.
        CurrentPlayer, Player currently making move.
        BuildsList, List of current builds on the table.
        BuildOwners, List of build owners.
        BuildFound, Uninstantiated variable to pass build found through.
**/
extendingBuild(CardSelected, CurrentPlayer, BuildsList, BuildOwners, BuildFound) :-
        % iterate through builds list
        % get list of builds that belong to current player
        % find a build in that updated list whos value is equal to CardSelected
        getPlayerOwnedBuilds(BuildsList, CurrentPlayer, BuildOwners, [], OwnedBuilds),
        findBuildWithSameVal(CardSelected, OwnedBuilds, [], PossibleBuild),
        BuildFound = PossibleBuild.

/**
Clause Name: getPlayerOwnedBuilds
Purpose: Find list of current builds owned by the player making move.
Parameters:
        BuildsList, List of all builds on the table.
        CurrentPlayer, Player currently making move.
        BuildOwners, List of current build owners.
        BuildsIn, Uninstantiated var to track list of builds throughout clauses runtime.
        BuildsOut, Uninstantiated var to send data back through the clause.
**/
getPlayerOwnedBuilds([], _, [], BuildsIn, BuildsOut) :-
        BuildsOut = BuildsIn.

getPlayerOwnedBuilds(BuildsList, CurrentPlayer, BuildOwners, BuildsIn, BuildsOut) :-
        [Build | RestOfBuilds] = BuildsList,
        [Owner | RestOfOwners] = BuildOwners,
        isBuildOwnedByPlayer(CurrentPlayer, Owner, Build, BuildsIn, AvailBuilds),
        getPlayerOwnedBuilds(RestOfBuilds, CurrentPlayer, RestOfOwners, AvailBuilds, BuildsOut).

/**
Clause Name: isBuildOwnedByPlayer
Purpose: Check to see if build is owned by player making move. Adds it to current avail builds list if true.
Parameters:
        CurrentPlayer, Player currently making move.
        Owned, Owner of currently checked build.
        BuildIn, Build in question.
        CurrentBuildsList, Current list of builds owned by player.
        BuildsOut, Uninstantiated var that will contain new list of builds after checking ownership.
**/
isBuildOwnedByPlayer(CurrentPlayer, Owner, BuildIn, CurrentBuildsList, BuildsOut) :-
        CurrentPlayer = Owner,
        append(CurrentBuildsList, [BuildIn], BuildsOut).

isBuildOwnedByPlayer(_, _, _, CurrentBuildsList, BuildsOut) :-
        BuildsOut = CurrentBuildsList.

/**
Clause Name: findBuildWithSameVal
Purpose: Attempts to find a build with the same value as the card selected. There will never be a case where you have 2 builds with the same value - they will have to be a multiple build.
Parameters:
        CardSelected, Card selected to sum build to.
        BuildsList, List of builds currently on the table.
        CurrentBuild, Build in question.
        PossibleBuild, Uninstantiated var to return possible builds.
**/
findBuildWithSameVal(_, _, CurrentBuild, PossibleBuild) :-
        CurrentBuild \= [],
        PossibleBuild = CurrentBuild.

findBuildWithSameVal(_, [], _, _).

findBuildWithSameVal(CardSelected, BuildsList, CurrentBuild, PossibleBuild) :-
        getValue(CardSelected, SelectedValue),
        [Build | Rest] = BuildsList,
        getBuildValue(Build, BuildValue),
        checkBuildValue(SelectedValue, BuildValue, Build, CheckedBuild),
        findBuildWithSameVal(CardSelected, Rest, CheckedBuild, PossibleBuild).

/**
Clause Name: checkBuildValue
Purpose: Checks to see if build in question has same value as card selected.
Parameters:
        SelectedValue, Value of card selected.
        BuildValue, Value that build sums to.
        CurrentBuild, Build in question.
        PossibleBuild, Uninstantiated var to return current build if it matches selected value, else it will be [].
**/
checkBuildValue(SelectedValue, BuildValue, CurrentBuild, PossibleBuild) :-
        SelectedValue = BuildValue,
        PossibleBuild = CurrentBuild.
checkBuildValue(_, _, _, PossibleBuild) :- PossibleBuild = [].

/**
Clause Name: validateBuildCreated
Purpose: Make sure build selected totals to selected card value correctly. Restarts round with current gamestate otherwise.
Parameters:
        State, List of variables involved in current game state.
        BuildVal, Total value of all cards in build created.
        SelectedValue, Value that build must sum to in order to be created.
**/
validateBuildCreated(State, BuildVal, SelectedValue) :-
        BuildVal = SelectedValue.

validateBuildCreated(State, BuildVal, SelectedValue) :-
        write('Build cannot be created. Set of cards selected totals to: '),
        write(BuildVal),
        write('. Needs to total to: '),
        write(SelectedValue), nl,
        assessRound(State).

/**
Clause Name: updateBuildList
Purpose: Update list of current builds after extending a single build to a multi build.
Parameters:
        BuildToExtend, Build selected to extend to a multiple build.
        NewBuild, New build created to extend with.
        BuildList, List of current builds on the table.
        BuildsIn, Uninstantiated var to pass build list within clause.
        BuildsOut, Uninstantiated var to pass final build list back through clause.
**/
updateBuildList(_, _, [], BuildsIn, BuildsOut) :- BuildsOut = BuildsIn.
updateBuildList(BuildToExtend, NewBuild, BuildList, BuildsIn, BuildsOut) :-
        % iterate through list of builds until BuildToExtend is Found, and append New Build
        [Build | Rest] = BuildList,
        checkBuildEquality(Build, BuildToExtend, NewBuild, BuildAfterCheck),
        append(BuildsIn, [BuildAfterCheck], CurrentBuildList),
        updateBuildList(BuildToExtend, NewBuild, Rest, CurrentBuildList, BuildsOut).

/**
Clause Name: checkBuildEquality
Purpose: While iterating through current build list, checks to see if a build in that list is equal to the one found for extending earlier.
If it is the correct build, the new build is appended to it and send back to continue iteration. If it is not, it simply returns the original build.
Parameters:
        Build, Build found via iteration through list.
        BuildToExtend, Build found to extend earlier.
        NewBuild, Build created by player to extend with.
        BuildOut, Uninstantiated var that is used to send updated build back through clause.
**/
checkBuildEquality(Build, BuildToExtend, NewBuild, BuildOut) :-
        Build = BuildToExtend,
        append(Build, [NewBuild], BuildOut).

checkBuildEquality(Build, _, NewBuild, BuildOut) :- BuildOut = Build.

/**
Clause Name: increase
Purpose: Increase and claim an opponents build
Parameters: 
        State, List of variables involved in game state.
        CardSelected, Card selected to increase the build to.
        CardPlayed, Card selected to play into the build.
        TableCardsBeforeMove, List of cards on the game table.
        BuildsBeforeMove, List of builds on the game table.
**/
increase(State, CardSelected, CardPlayed, TableCardsBeforeMove, HumanHandBeforeMove, BuildsBeforeMove) :-
        getValue(CardSelected, SelectedValue),
        getValue(CardPlayed, PlayedVal),
        getBuildSelection(State, SelectedValue, PlayedVal, BuildsBeforeMove, BuildToIncrease),
        write('Selected to increase build: '), printBuilds([BuildToIncrease]),
        write('. By playing card: '), printCards([CardPlayed]), nl,
        % make sure build is owned by opponent
        getPlayNextFromState(State, CurrentPlayer),
        getBuildOwnersFromState(State, BuildOwners),
        validateBuild(State, BuildToIncrease, BuildsBeforeMove, BuildOwners, CurrentPlayer),
        % update build
        indexOf(BuildsBeforeMove, BuildToIncrease, IndexOfBuild),
        increaseBuild(CardPlayed, BuildToIncrease, IndexOfBuild, CurrentPlayer, BuildOwners, IncreasedBuild, NewBuildOwners),
        write('New build of: '), printBuilds([IncreasedBuild]),
        write('. Has been created and is now owned by: '), write(CurrentPlayer), nl,
        % update model
        replaceElement(IndexOfBuild, BuildsBeforeMove, IncreasedBuild, BuildsAfterMove),
        removeCardFromList(CardPlayed, HumanHandBeforeMove, HumanHandAfterMove),
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanPileFromState(State, HumanPile),
        getHumanScoreFromState(State, HumanScore),
        getComputerHandFromState(State, ComputerHand),
        getComputerPileFromState(State, ComputerPile),
        getComputerScoreFromState(State, ComputerScore),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        getLastCapturerFromState(State, LastCapturer),
        NewState = [RoundNum, ComputerScore, ComputerHand, ComputerPile, HumanScore, HumanHandAfterMove, HumanPile, TableCardsBeforeMove, BuildsAfterMove, NewBuildOwners, LastCapturer, GameDeck, NextPlayer],
        assessRound(NewState).

/**
Clause Name: getBuildSelection
Purpose: Get Build to increase selected by user.
Parameters:
        State, List of variables involved in current game state.
        SelectedValue, Value of card selected aka value that build will be increased to.
        PlayedVal, Value of card to be played into the build.
        BuildsBeforeMove, List of builds on the table.
        BuildToIncrease, Uninstantiated var that will contain the Build selected to increase.
**/
getBuildSelection(State, CurrentPlayer, SelectedValue, PlayedVal, BuildsBeforeMove, BuildToIncrease) :-
        CurrentPlayer = human,
        getBuildForUser(State, BuildsBeforeMove, BuildSelected),
        getBuildValue(BuildSelected, BuildVal),
        assessBuildValue(State, SelectedValue, PlayedVal, BuildVal),
        BuildToIncrease = BuildSelected.

/**
Clause Name: getBuildForUser
Purpose: Get user input for build selected, validates input and returns build selected if possible.
Parameters: 
        State, List of variables involved in current game state.
        BuildsBeforeMove, List of builds on the table.
        BuildSelected, Uninstantiated variable that will contain Build selected to increase.
**/
getBuildForUser(State, BuildsBeforeMove, BuildSelected) :-
        write('Which build would you like to increase?: '),
        printBuilds(BuildsBeforeMove),
        read(BuildInput),
        assessBuildInput(State, BuildsBeforeMove, BuildInput, BuildSelected).

getBuildForUser(State, [], _) :-
        write('No builds available for increase. Try again.'), nl,
        assessRound(State).

/**
Clause Name: assessBuildInput
Purpose: Tries to select build given user input, fails and restarts current round if invalid input.
Parameters:
        State, List of variables involved in current game state.
        BuildsList, List of current builds on the table.
        Input, Index of build selected by user.
        BuildChosen, Uninstantiated variable that will contain Build selected to increase.
**/
assessBuildInput(State, BuildsList, Input, BuildChosen) :-
        nth0(Input, BuildsList, BuildChosen).
assessBuildInput(State, _, _, _) :-
        write('Invalid input. Try again.'), nl,
        assessRound(State).

/**
Clause Name: assessBuildValue
Purpose: Checks to make sure build selected can be increased and claimed with cards involved.
Parameters:
        State, List of variables involved in current game state.
        SelectedValue, Value of card selected to sum the increased build to.
        PlayedVal, Value of card played into the build.
        BuildVal, Value of the current build selected.
**/
assessBuildValue(State, SelectedValue, PlayedVal, BuildVal) :-
        SelectedValue is PlayedVal + BuildVal.

assessBuildValue(State, SelectedValue, PlayedVal, BuildVal) :-
        write('Cannot increase build. Build with value: '),
        write(BuildVal),
        write('. With added value of: '),
        write(PlayedVal),
        write('. Does not sum to card selected: '),
        write(SelectedValue), nl,
        assessRound(State).

/**
Clause Name: validateBuild
Purpose: Make sure that build selected for increase belongs to opponent
Parameters:
        State, List of variables involved in current game state.
        BuildSelected, Build selected by player to increase.
        CurrentBuilds, List of builds currently on the table.
        BuildOwners, List of build owners.
        CurrentPlayer, Player currently making move.
**/
validateBuild(State, BuildSelected, CurrentBuilds, BuildOwners, CurrentPlayer) :-
        checkIsMultiBuild(State, BuildSelected),
        indexOf(CurrentBuilds, BuildSelected, Index), 
        nth0(Index, BuildOwners, Owner),
        checkIsOpponentsBuild(State, CurrentPlayer, Owner).

/**
Clause Name: checkIsMultiBuild
Purpose: Checks to see if a build is a multi-build; if it is you cannot increase it.
Parameters:
        State, List of variables involved in current game state.
        BuildSelected, Build selected by player to increase.
**/
checkIsMultiBuild(_, BuildSelected) :-
        length(BuildSelected, 1).

checkIsMultiBuild(State, _) :-
        write('Cannot increase a multi-build. Try again.'),
        assessRound(State).

/**
Clause Name: checkIsOpponentsBuild
Purpose: Check to see if build selected belongs to opponent.
Parameters:
        State, List of variables involved in current game state.
        CurrentPlayer, Player currently making move.
        Owner, Player that owns the build selected.
**/
checkIsOpponentsBuild(State, CurrentPlayer, Owner) :-
        CurrentPlayer \= Owner.

checkIsOpponentsBuild(State, _, _) :-
        write('This build belongs to you, increase move cannot be made. Try again.'), nl,
        assessRound(State).

/**
Clause Name: increaseBuild
Purpose: Change the build selected for increase and update the build owners list after selection is validated.
Parameters:
        CardPlayed, Card played into build.
        BuildSelected, Build selected to increase.
        IndexOfBuild, Index in the build list of the build selected; used to update the build owners list.
        CurrentPlayer, Player currently making move.
        BuildOwners, List of build onwers.
        NewBuild, New build after CardPlayed is added to build.
        NewBuildOwners, New build owners list after ownership is changed.
**/
increaseBuild(CardPlayed, BuildSelected, IndexOfBuild, CurrentPlayer, BuildOwners, NewBuild, NewBuildOwners) :-
        [Build | _] = BuildSelected,
        append(Build, [CardPlayed], AppendedBuild),
        NewBuild = [AppendedBuild],
        replaceElement(IndexOfBuild, BuildOwners, CurrentPlayer, NewBuildOwners).

/**
Clause Name: capture
Purpose: Make a capture move selected by player.
Parameters:
    Card, Card selected by player.
    TableCardsBeforeMove, List of cards on the table before move is made.
    TableCardsAfterMove, Uninstantiated variable that will contain list of cards after move is made.
    HumanHandBeforeMove, List of cards in player's hand before move is made.
    HumanHandAfterMove, Uninstantiated variable that will contain list of cards in hand after move is made.
    HumanPileBeforeMove, List of cards in player's pile before move is made.
    HumanPileAfterMove, Uninstantiated variable that will contain list of cards in pile after move is made.
**/

/** Can capture same face cards, builds, and sets **/
capture(State, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumaileAfterMove, BuildsBeforeMove, BuildsAfterMove) :-
        /** Same face capture **/
        getCapturableCards(TableCardsBeforeMove, Card, CapturableCardsBefore, CapturableCardsAfter),
        removeCardsFromList(CapturableCardsAfter, TableCardsBeforeMove, TableCardsAfterSameVal),
        write('Player has selected to capture: '), printCards(CapturableCardsAfter), write('with card:'), printCards([Card]), nl,
        /** Build capture **/
        getBuildOwnersFromState(State, BuildOwners),
        getCapturableBuilds(Card, BuildsBeforeMove, _, CapturableBuilds),
        write('Player will also capture: '), printBuilds(CapturedBuilds), nl,
        % Issue here when more than one build is being captured at once.
        removeBuildOwners(CapturedBuilds, BuildsBeforeMove, BuildOwners, NewBuildOwners),
        removeSetsFromList(CapturedBuilds, BuildsBeforeMove, BuildsAfterMove),
        /** Set capture **/
        getCapturableSetsForAI(Card, TableCardsAfterSameVal, CapturableSets),
        capturerIsHuman(State, HumanHandBeforeMove, human, CapturableCardsAfter, CaptureableBuilds, CapturableBuildsAfterPrompt, CapturableSets, CapturableSetsAfterPrompt),
        write('Player will also capture via sets: '), printSets(CapturableSetsAfterPrompt), nl,
        flattenList(CapturableSets, _, CapturableSetsAsList),
        removeSetsFromList(CapturableSetsAsList, TableCardsAfterSameVal, TableCardsAfterMove),
        append(HumanPileBeforeMove, [Card], HumanPileWithCaptureCard),
        flattenList(CapturableBuildsAfterPrompt, _, BuildCardsCaptured),
        flattenList(BuildCardsCaptured, _, FlatBuildCards),
        append(HumanPileWithCaptureCard, FlatBuildCards, HumanPileWithBuilds),
        append(HumanPileWithBuilds, CapturableCardsAfter, HumanPileAfterSameVal),
        flattenList(CapturableSets, _, CapturableSetsAsList),
        append(HumanPileAfterSameVal, CapturableSetsAsList, HumanPileAfterMove),
        removeCardFromList(Card, HumanHandBeforeMove, HumanHandAfterMove),
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanScoreFromState(State, HumanScore),
        getComputerScoreFromState(State, ComputerScore),
        getComputerHandFromState(State, ComputerHand),
        getComputerPileFromState(State, ComputerPile),
        getPlayNextFromState(State, CurrentPlayer),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        NewState = [RoundNum, ComputerScore, ComputerHand, ComputerPile, HumanScore, HumanHandAfterMove, HumanPileAfterMove, TableCardsAfterMove, BuildsAfterMove, NewBuildOwners, CurrentPlayer, GameDeck, NextPlayer],
        assessRound(NewState).

/**
Clause Name: promptSameFaceCapture
Purpose: Prompt a user whether or not they want to capture same face cards.
Parameters: 
        State, list of vars in game state.
        CapturableCards, List of capturable cards
**/
promptSameFaceCapture(State, []).
promptSameFaceCapture(State, CapturableCards) :-
        write('Do you want to capture the following cards? (y/n): '),
        printCards(CapturableCards),
        read(Input),
        assessSameFaceInput(State, Input).

/**
Clause Name: assessSameFaceInput
Purpose: After user is prompted to capture same face cards, assess and follow ruleset.
Parameters:
        State, List of variables in current game state.
        Input, User input for same face capture prompt.
**/
assessSameFaceInput(State, Input) :-
        Input = n,
        write('Must capture all same face cards on the table. Try again.'), nl,
        assessRound(State).

assessSameFaceInput(_, y).

assessSameFaceInput(State, _) :-
        write('Invalid input. Try again.'), nl,
        assessRound(State).

/**
Clause Name: promptBuildCapture
Purpose: Prompt a user whether or not they want to capture builds.
Parameters:
        CapturableBuilds, list of builds that can be captured.
        CapturableBuildsAfterPrompt, uninstantiated var that will contain the list of builds captured after prompt.
**/
promptBuildCapture(_, _, CapturableBuilds, CapturableBuildsAfterPrompt) :-
        CapturableBuilds = [],
        CapturableBuildsAfterPrompt = CapturableBuilds.

promptBuildCapture(State, PlayerHand, CapturableBuilds, CapturableBuildsAfterPrompt) :-
        write('Do you want to capture the following builds? (y/n): '),
        printBuilds(CapturableBuilds),
        read(Input),
        validateBuildInput(State, PlayerHand, Input, CapturableBuilds, CapturableBuildsAfterPrompt).

/**
Clause Name: validateBuildInput
Purpose: Checks to make sure the user input for build capture is correct. Also, if user selects not to capture a build with their last capture card, it will fail.
Parameters:
        State, List of variables used i game state.
        PlayerHand, List of cards in player's hand.
        BuildsIn, Capturable builds.
        BuildsOut, Used to return capturable builds if user selects to capture, [] otherwise.
**/
validateBuildInput(State, PlayerHand, Input, BuildsIn, BuildsOut) :-
        Input = n,
        checkCaptureCards(State, PlayerHand, BuildsIn),
        BuildsOut = [].

validateBuildInput(_, _, Input, BuildsIn, BuildsOut) :-
        Input = y,
        BuildsOut = BuildsIn.

validateBuildInput(State, _, _, _, _) :-
        write('Invalid input. Try again.'), nl,
        assessRound(State).

/**
Clause Name: checkCaptureCards
Purpose: Checks to see if there is more than one capture card in player's hand.
Parameters:
        State, List of variables involved in game state.
        PlayerHand, List of cards in player's hand.
        Builds, List of capturable builds.
**/
checkCaptureCards(State, PlayerHand, Builds) :-
        [Build | _] = Builds,
        getBuildValue(Build, BuildVal),
        getCaptureCardsInHand(PlayerHand, BuildVal, _, CaptureCards),
        assessNumberOfCaptureCards(State, CaptureCards).

/**
Clause Name: getCaptureCardsInHand
Purpose: Generates a list of viable capture cards in hand.
Paramaters:
        PlayerHand, List of cards in player's hand.
        BuildVal, Sum value of the build(s) to be captured.
        CardsIn, Uninstantiated variable to keep track of capture cards within clause.
        CardsOut, Uninstantiated variable to pass list of capture cards out of clause.
**/
getCaptureCardsInHand([], _, CardsIn, CardsOut) :- CardsOut = CardsIn.

getCaptureCardsInHand(PlayerHand, BuildVal, CardsIn, CardsOut) :-
        [Card | Rest] = PlayerHand,
        getValue(Card, CaptureValue),
        assessCaptureValue(Card, CaptureValue, BuildVal, CardsIn, CardsAfterAssessment),
        getCaptureCardsInHand(Rest, BuildVal, CardsAfterAssessment, CardsOut).

/**
Clause Name: assessCaptureValue
Purpose: Assesses the value of card in question to see if it can be used as a capture card. If it can, it is added to the current list.
Parameters:
        Card, Card in question.
        CaptureValue, Value of card.
        BuildVal, Value of build(s) to be captured.
        CardsIn, List of viable capture cards passed in.
        CardsOut, Uninstantiated variable to send updated list out of clause.
**/
assessCaptureValue(Card, CaptureValue, BuildVal, CardsIn, CardsOut) :-
        CaptureValue = BuildVal,
        append(CardsIn, [Card], CardsOut).

assessCaptureValue(_, _, _, CardsIn, CardsOut) :- CardsOut = CardsIn.

/**
Clause Name: assessNumerOfCaptureCards
Purpose: If only one possible capture card exists, print error message and restart turn.
Parameters:
        State, List of variables involved in current game state.
        CaptureCards, List of possible capture cards found.
**/
assessNumberOfCaptureCards(State, CaptureCards) :-
        length(CaptureCards, 1),
        write('Must capture build, this is the only capture card. Try again.'), nl,
        assessRound(State).
assessNumberOfCaptureCards(_, _).

/**
Clause Name: promptSetCapture
Purpose: Prompt a user whether or not they want to capture sets.
Parameters:
        State, list of variables involved in a game state.
        CardPlayed, Card selected to be played by user.
        TableCards, List of cards on the table.
        CapturableCards, List of capturable cards.
        CapturableBuilds, List of capturable builds on the table.
        CapturableSets, Uninstantiated var that will contain all capturable sets.
**/
promptSetCapture(State, CardPlayed, TableCards, CapturableCards, CapturableBuilds, CapturableSets) :-
        CapturableCards = [],
        CapturableBuilds = [],
        write('Would you like to select sets to capture? (y/n): '),
        read(Input),
        Input = n,
        write('No move made. Try again'), nl,
        assessRound(State).

promptSetCapture(State, CardPlayed, TableCards, CapturableCards, CapturableBuilds, CapturableSets) :-
        write('Would you like to select sets to capture? (y/n): '),
        read(Input),
        Input = n,        
        CapturableSets = [].

promptSetCapture(State, CardPlayed, TableCards, CapturableCards, CapturabledBuilds, CapturableSets) :-
        getCapturableSets(State, y, CardPlayed, TableCards, [], CapturableSetsAfter),
        CapturableSets = CapturableSetsAfter.

/**
Clause Name: getCapturableCards
Purpose: Find all capturable cards and report them back to player.
Parameters:
    TableCards, List of cards on the game table.
    CardPlayed, Card selected for play by player.
    CapturableCardsBefore, Uninstantiated list of cards that can be captured.
    CapturableCardsAfterm, Uninstantiated list that will contain all cards capturable.
**/
getCapturableCards(TableCards, CardPlayed, CapturableCardsBefore, CapturableCardsAfter) :-
        TableCards = [],
        CapturableCardsAfter = CapturableCardsBefore.

getCapturableCards(TableCards, CardPlayed, CapturableCardsBefore, CapturableCardsAfter) :-
        (_, PlayedType) = CardPlayed,
        [TableCard | Rest] = TableCards,
        (_, TableCardType) = TableCard,
        PlayedType = TableCardType,
        append(CapturableCardsBefore, [TableCard], NewCapList),
        getCapturableCards(Rest, CardPlayed, NewCapList, CapturableCardsAfter).

getCapturableCards(TableCards, CardPlayed, CapturableCardsBefore, CapturableCardsAfter) :-
        [_ | Rest] = TableCards,
        getCapturableCards(Rest, CardPlayed, CapturableCardsBefore, CapturableCardsAfter).

/**
Clause Name: getCapturableBuilds
Purpose: Get list of capturable builds on the table.
Parameters:
    CardPlayed, Card selected to be played into the build.
    BuildsList, List of current builds in the game
    CapturableBuilds1, Uninstantiated var containing list of builds that can be captured.
    CapturableBuilds2, Uninstantiated var that will be used to send CB1 through.
**/
getCapturableBuilds(_, [], CapturableBuilds1, CapturableBuilds2) :-
        CapturableBuilds2 = CapturableBuilds1.

getCapturableBuilds(CardPlayed, BuildsList, CapturableBuilds1, CapturableBuilds2) :-
        getValue(CardPlayed, PlayedVal),
        [B1 | Rest] = BuildsList,
        getBuildValue(B1, BuildVal),
        PlayedVal = BuildVal,
        append(CapturableBuilds1, [B1], NewBuilds),
        getCapturableBuilds(CardPlayed, Rest, NewBuilds, CapturableBuilds2).

getCapturableBuilds(CardPlayed, BuildsList, CapturableBuilds1, CapturableBuilds2) :-
        [_ | Rest] = BuildsList,
        getCapturableBuilds(CardPlayed, Rest, CapturableBuilds1, CapturableBuilds2).

/**
Clause Name: addCapturedSetsToPile
Purpose: Adds captured builds to the player's pile.
Paramaters:
    CapturableBuilds, List of builds captured by player.
    HumanPileBefore, List of cards in player's pile before move is made.
    HumanPileAfter, Uninstantiated variable that will contain all cards in the player's pile after move is made.
**/
addCapturedSetsToPile([], HumanPileBefore, HumanPileAfter) :-
        HumanPileAfter = HumanPileBefore.

addCapturedSetsToPile(CapturableBuilds, HumanPileBefore, HumanPileAfter) :-
        [B1 | Rest] = CapturableBuilds,
        append(HumanPileBefore, B1, NewHumanPile),
        addCapturedSetsToPile(Rest, NewHumanPile, HumanPileAfter).

/**
Clause Name: getCapturableSets
Purpose: Get list of capturable sets
Parameters:
    Input, User input as to whether or not they want to continue selecting sets for capture.
    Card, Card selected to capture with.
    TableCardsBeforeMove, List of cards on the table before the sets are generated for capture.
    CapturableSetsBefore, Uninstantiated var to keep track of Capturable Sets
    CapturableSetsAfter, Uninstantiated var used to send capturable sets through.
**/
getCapturableSets(State, Input, Card, TableCardsBeforeMove, CapturableSetsBefore, CapturableSetsAfter) :-
        Input = n,
        CapturableSetsAfter = CapturableSetsBefore.

getCapturableSets(State, Input, Card, TableCardsBeforeMove, CabturableSetsBefore, CapturableSetsAfter) :-
        getTableCardsForSets(TableCardsBeforeMove, SingleSet),
        getSetValue(SingleSet, 0, SetVal),
        getValue(Card, PlayedVal),
        evaluateSet(State, PlayedVal, SetVal, SingleSet, SetAfterEval),
        append(CapturableSetsBefore, [SetAfterEval], NewSets),
        removeSetFromList(TableCardsBeforeMove, [SetAfterEval], [], TableCardsAfterMove),
        write('Would you like to select another set for capture? (y/n)'),
        read(SetInput),
        getCapturableSets(State, SetInput, Card, TableCardsAfterMove, NewSets, CapturableSetsAfter).

getCapturableSets(_, Card, TableCardsBeforeMove, CapturableCardsBefore, CapturableCardsAfter) :-
        CapturableSetsAfter = [].

/**
Clause Name: evaluateSet
Purpose: Evaluate whether set entered is possible.
Parameters:
        State, List of variables in game state.
        PlayedVal, Numerical value of card played.
        SetVal, Numerical value of set of cards selected.
        Set, List of cards selected in set.
        SetAfterEval, Uninstantiated variable that will contain list of cards in set.
**/
evaluateSet(State, PlayedVal, SetVal, Set, SetAfterEval) :-
        PlayedVal = SetVal,
        SetAfterEval = Set.

evaluateSet(State, PlayedVal, SetVal, Set, SetAfterEval) :-
        write('Invalid set entered. Sum of set: '), 
        write(SetVal), 
        write('. Needed to add up to: '),
        write(PlayedVal),
        write('. Try again.'), nl,
        assessRound(State).