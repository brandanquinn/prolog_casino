/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************
* Game Utility Clauses     *                  
***************************/

/**
Clause Name: deck
Purpose: Generate a Deck List
Parameters: Takes an uninstantiated variable and assigns to it the pre-built deck list.
**/
deck([
    (h, 2), (h, 2), (h, 3), (h, 4), (h, 5), (h, 6), (h, 7), (h, 8), (h, 9), (h, x), (h, j), (h, q), (h, k), (h, a),
    (s, 2), (s, 2), (s, 3), (s, 4), (s, 5), (s, 6), (s, 7), (s, 8), (s, 9), (s, x), (s, j), (s, q), (s, k), (s, a),
    (d, 2), (d, 2), (d, 3), (d, 4), (d, 5), (d, 6), (d, 7), (d, 8), (d, 9), (d, x), (d, j), (d, q), (d, k), (d, a),
    (c, 2), (c, 2), (c, 3), (c, 4), (c, 5), (c, 6), (c, 7), (c, 8), (c, 9), (c, x), (c, j), (c, q), (c, k), (c, a)
]).

/**
Clause Name: shuffledeck
Purpose: Shuffle a Deck List and assign it to a variable
Parameters: Variable to assign shuffled deck list to.
Algorithm: 
    1. Assign pre-built deck list to Deck variable
    2. Call random_permutation() to shuffle pre-built deck list and assign the new list to ShuffledDeck variable 
**/
shuffleDeck(NewGameDeck, GameDeckBeforeMove) :- deck(NewGameDeck),
                            random_permutation(NewGameDeck, GameDeckBeforeMove).

/**
Clause Name: getValue
Purpose: Get the value of a card given its type.
Parameters:
        (_, Type), 
**/
getValue((_, Type), Value) :- 
        Type = x,
        Value = 10.

getValue((_, Type), Value) :-
        Type = j,
        Value = 11.

getValue((_, Type), Value) :-
        Type = q,
        Value = 12.

getValue((_, Type), Value) :-
        Type = k,
        Value = 13.

getValue((_, Type), Value) :-
        Type = a,
        Value = 14.

getValue((_, Type), Value) :-
        Type \= x,
        Type \= j,
        Type \= q,
        Type \= k,
        Type \= a,
        Value = Type.

/**
Clause Name: coinToss
Purpose: Tosses coin and checks if player called it correctly. If true, they go first. Else computer goes first.
Parameters:
        Input, Heads or Tails call by player.
        NextPlayer, Player that will go first depending on result of coin toss.
**/
coinToss(Input, NextPlayer) :-
        verifyCall(Input),
        Odds = [h, t],
        random_permutation(Odds, Flip),
        assessCall(Input, Flip, NextPlayer).

/**
Clause Name: verifyCall
Purpose: Verify that coin toss input is correct.
Parameters:
        Input, Coin toss call by player.
**/
verifyCall(Input) :-
        Input = h.

verifyCall(Input) :-
        Input = t.

verifyCall(_) :-
        write('Invalid input for coin toss. Try again.'), nl,
        setupRound().

/**
Clause Name: assessCall
Purpose: Checks to see if player's call was correct or not, sends back player going first.
Paramaters:
        Call, Verified coin toss call by player.
        FlipResult, After coin toss is simulated - this represents the result of the flip.
        NextPlayer, Player who will go first depending on result of toss.
**/
assessCall(Call, [FlipResult | _], NextPlayer) :-
        Call = FlipResult,
        write('Congrats, you won the coin toss!'), nl,
        NextPlayer = human.

assessCall(_, _, NextPlayer) :-
        write('Unfortunately youve lost the coin toss.'), nl,
        NextPlayer = computer.

/**
Clause Name: draw
Purpose: Draw a Card from the top of the deck.
Parameters: Takes an uninstantiated Card variable and a Deck List
Algorithm: Pulls the top card from the Deck List and assigns it to the Card variable.
**/
draw(Card, GameDeck, NewGameDeck) :- 
            GameDeck = [Card | Rest],
            NewGameDeck = Rest.

/**
Clause Name: dealCards
Purpose: Deals 4 cards.
Parameters:
    GameDeckBeforeDeal, List of cards in game deck before cards are dealt.
    GameDeckAfterDeal, Uninstantiated var that will contain list of cards in game deck after cards are dealt.
    CardList, Uninstantiated var that will contain list of cards dealt.
**/
dealCards(GameDeckBeforeDeal, GameDeckAfterDeal, CardList) :-
        draw(CardOne, GameDeckBeforeDeal, GD1),
        draw(CardTwo, GD1, GD2),
        draw(CardThree, GD2, GD3),
        draw(CardFour, GD3, GD4),
        GameDeckAfterDeal = GD4,
        CardList = [CardOne, CardTwo, CardThree, CardFour].

/**
Clause Name: checkHandsEmpty
Purpose: Checks to see if both players hands are empty and re-deals cards as necessary.
Parameters
    HumanHand, List of Cards already in Human player's hand.
    NewHumanHand, Variable to be instantiated to new list of cards in human's hand.
    ComputerHand, List of Cards already in Computer player's hand.
    NewComputerHand, Variable to be instantiated to new list of cards in computer's hand.
    GameDeck, List of cards in Game deck
    CNewGameDeck, List of cards in game deck after being dealt new cards.
**/
checkHandsEmpty(HumanHand, NewHumanHand, ComputerHand, NewComputerHand, GameDeck, CNewGameDeck) :-
        HumanHand = [],
        ComputerHand = [],
        dealCards(GameDeck, HNewGameDeck, NewHumanHand),
        dealCards(HNewGameDeck, CNewGameDeck, NewComputerHand).
                                    
checkHandsEmpty(HumanHand, NewHumanHand, ComputerHand, NewComputerHand, GameDeck, CNewGameDeck) :-
        CNewGameDeck = GameDeck,      
        NewHumanHand = HumanHand,
        NewComputerHand = ComputerHand.

/**
Clause Name: getCurrentPlayersHand
Purpose: Get hand of current player making move.
Parameters:
        State, List of variables in current game state.
        CurrentPlayer, Player currently making move.
        PlayerHand, Uninstantiated variable to send players hand to.
**/
getCurrentPlayersHand(State, CurrentPlayer, PlayerHand) :-
        CurrentPlayer = human,
        getHumanHandFromState(State, PlayerHand).

getCurrentPlayersHand(State, CurrentPlayer, PlayerHand) :-
        CurrentPlayer = computer,
        getComputerHandFromState(State, PlayerHand).

/**
Clause Name: getCurrentPlayersPile
Purpose: Get pile of current player making move.
Parameters:
        State, List of variables in current game state.
        CurrentPlayer, Player currently making move.
        PlayerPile, Uninstantiated variable to send players pile to.
**/
getCurrentPlayersPile(State, CurrentPlayer, PlayerPile) :-
        CurrentPlayer = human,
        getHumanPileFromState(State, PlayerPile).

getCurrentPlayersPile(State, CurrentPlayer, PlayerPile) :-
        CurrentPlayer = computer,
        getComputerPileFromState(State, PlayerPile).

/**
Clause Name: whosPlayingNext
Purpose: Get player of next turn.
Parameters:
        CurrentPlayer, player who just made a move.
        NextPlayer, player who is playing next.
**/
whosPlayingNext(CurrentPlayer, NextPlayer) :-
        CurrentPlayer = human,
        NextPlayer = computer.

whosPlayingNext(CurrentPlayer, NextPlayer) :-
        CurrentPlayer = computer,
        NextPlayer = human.

/**
Clause Name: getSaveFileName
Purpose: Gets the name of a save file and adds .txt by default.
Parameters:
        SaveFileName, Uninstantiated variable to pass user input through.
**/
getSaveFileName(SaveFileName) :-
        write('What is the name of your save file? '),
        read(FileNameInput),
        string_concat('save_files/', FileNameInput, FilePath),
        string_concat(FilePath, '.txt', SaveFileName).

/**
Clause Name: getSelection
Purpose: Continuously select cards from a given list, until -1 is input.
Parameters:
    TableCardsBeforeMove, List of cards on the table before a move is made.
    TableCardsForBuild, List of cards selected for a build.
    FinalCardsSelected, Uninstantiated list of cards that will contain the final list.
    Input, User input to select card. 
**/
getSelection([], _, _, _).

getSelection(TableCardsBeforeMove, TableCardsForBuild, FinalCardsSelected, Input) :-
        Input = -1,
        FinalCardsSelected = TableCardsForBuild.

getSelection(TableCardsBeforeMove, [], FinalCardsSelected, Input) :-
        selectCard(TableCardsBeforeMove, TableCardSelected, Input),
        append(TableCardsForBuild, [TableCardSelected], NewCardsSelected),
        removeCardFromList(TableCardSelected, TableCardsBeforeMove, NewTableCards),
        write('Select the card you want to add to set: '),
        printCards(NewTableCards),
        read(NewInput),
        getSelection(NewTableCards, NewCardsSelected, FinalCardsSelected, NewInput).


getSelection(TableCardsBeforeMove, TableCardsForBuild, FinalCardsSelected, Input) :-
        selectCard(TableCardsBeforeMove, TableCardSelected, Input),
        append(TableCardsForBuild, [TableCardSelected], NewCardsSelected),
        removeCardFromList(TableCardSelected, TableCardsBeforeMove, NewTableCards),
        write('Cards currently selected: '), printCards(NewCardsSelected), nl,
        write('Select the card(s) you want to add to set: '),
        printCards(NewTableCards),
        read(NewInput),
        getSelection(NewTableCards, NewCardsSelected, FinalCardsSelected, NewInput).

/**
Clause Name: getTableCardsForSets
Purpose: Wrapper to get cards selected for set capture by user.
Parameters:
    TableCardsBeforeMove, List of cards to be selected from the table.
    FinalCardsSelected, List of cards selected by user.
**/
getTableCardsForSets(TableCardsBeforeMove, FinalCardsSelected) :-
        write('Select the card you want to add to set for capture: '),
        printCards(TableCardsBeforeMove),
        read(Input),
        getSelection(TableCardsBeforeMove, [], FinalCardsSelected, Input),
        write('Cards selected from table: '), printCards(FinalCardsSelected), nl.

/**
Clause Name: getTableCardsForBuild
Purpose: Wrapper to get cards selected for build by user.
Parameters:
    TableCardsBeforeMove, List of cards to be selected from the table.
    FinalCardsSelected, List of cards selected by user.
**/
getTableCardsForBuild(TableCardsBeforeMove, FinalCardsSelected) :-
        write('Select the card you want to build with: '),
        printCards(TableCardsBeforeMove),
        read(Input),
        getSelection(TableCardsBeforeMove, [], FinalCardsSelected, Input),
        write('Cards selected from table: '), printCards(FinalCardsSelected), nl.

aiGetTableCardsForBuild(CardSelected, CardPlayed, TableCards, FinalCardsSelected) :-
        getAllSubsets(TableCards, SubsetList),
        removeCardFromList([], SubsetList, UpdatedList),
        getValue(CardSelected, SelectedValue),
        getSetValue([CardPlayed], 0, PlayedVal),
        findViableSubset(UpdatedList, SelectedValue, PlayedVal, _, FinalCardsSelected).

/**
Clause Name: getAllSubsets
Purpose: Find all subsets of a current list.
Parameters:
        TableCards, List of cards to find subsets of.
        SubsetList, Uninstantiated variable that will contain list of all possible subsets.
**/
getAllSubsets(TableCards, SubsetList) :-
        findall(X, subset(TableCards, X), SubsetList).



/**
Clause Name: findViableSubset
Purpose: Evaluate each generated subset and find one that has needed sum value.
Parameters:
        SubsetList, List of all possible subsets.
        SelectedValue, Value of card selected to sum build to.
        PlayedVal, Value of card played into the build.
        SetIn, Uninstantiated variable to generate set within clause.
        SetOut, Uninstantiated variable to send set found back out of clause.
**/
findViableSubset([], _, _, [], SetOut) :- SetOut = [].

findViableSubset(_, _, _, SetIn, SetOut) :-
        SetIn \= [],
        SetOut = SetIn.

findViableSubset(SubsetList, SelectedValue, PlayedVal, SetIn, SetOut) :-
        [Set | Rest] = SubsetList,
        getSetValue(Set, 0, SetVal),
        assessSetVal(SetVal, SelectedValue, PlayedVal, Set, SetAfterAssessment),
        findViableSubset(Rest, SelectedValue, PlayedVal, SetAfterAssessment, SetOut).

/**
Clause Name: findCapturableSubsets
Purpose: Assess each subset in list and find ones that are capturable.
Parameters:
        TableCards, List of cards on the game table.
        SubsetList, List of subsets.
        CaptureValue, Value to capture subsets with.
        SetsIn, Uninstantiated variable to generate sets within clause.
        SetsOut, Uninstantiated variable to send sets found back out of clause.
**/
findCapturableSubsets(_, [], _, SetsIn, SetsOut) :- SetsOut = SetsIn.

findCapturableSubsets(TableCards, SubsetList, CaptureValue, SetsIn, SetsOut) :-
        [Set | Rest] = SubsetList,
        getSetValue(Set, 0, SetVal),
        assessSetValForCapture(SetVal, CaptureValue, Set, SetAfterAssessment, SetsIn, SetsAfterAssess),
        capturableSetFound(SetAfterAssessment, TableCards, UpdatedTableCards, Rest, UpdatedSubsetList),
        findCapturableSubsets(UpdatedTableCards, UpdatedSubsetList, CaptureValue, SetsAfterAssess, SetsOut).



/**
Clause Name: assessSetVal
Purpose: Check value of set to see if it is viable.
Parameters:
        SetVal, Value of set found.
        SelectedValue, Value that set + played card must sum to.
        PlayedVal, Value of card played.
        ViableSet, Set passed in for assessment.
        SetAfterAssessment, If set passed assessment, it is send back here. Else it will be instantiated to [].
**/
assessSetVal(SetVal, SelectedValue, PlayedVal, ViableSet, SetAfterAssessment) :-
        SelectedValue is SetVal + PlayedVal,
        SetAfterAssessment = ViableSet.

assessSetVal(_, _, _, _, SetAfterAssessment) :- SetAfterAssessment = [].

/**
Clause Name: assessSetValForCapture
Purpose: Checks to see if a set is capturable, adds it to the current list if so.
Parameters:
        SetVal, Value of set being assessed.
        CaptureValue, Value of card used to capture set.
        SetToAssess, Set being assessed.
        SetAfterAssessment, Uninstantiated variable which will either share the value of SetToAssess or will end up [] if set cannot be captured.
        SetsIn, List of sets being passed into clause.
        SetsOut, Uninstantiated variable to pass updated sets list back out of clause.
**/
assessSetValForCapture(SetVal, CaptureValue, SetToAssess, SetAfterAssessment, SetsIn, SetsOut) :-
        CaptureValue = SetVal,
        SetAfterAssessment = SetToAssess,
        append(SetsIn, [SetToAssess], SetsOut).

assessSetValForCapture(_, _, _, SetAfterAssessment, SetsIn, SetsOut) :- 
        SetAfterAssessment = [],
        SetsOut = SetsIn.

/**
Clause Name: capturableSetFound
Purpose: If a capturable set is found, update the subset list to avoid duplicates.
Parameters:
        Set, Set being assessed.
        TableCards, list of cards on the table.
        TableCardsOut, Updated table cards list being passed out of clause.
        SubsetList, list of subsets being assessed.
        SubsetListOut, Updated subset list being passed out of clause.
**/
capturableSetFound(Set, TableCards, TableCardsOut, SubsetList, SubsetListOut) :-
        Set = [],
        TableCardsOut = TableCards,
        SubsetListOut = SubsetList.

capturableSetFound(Set, TableCards, TableCardsOut, _, SubsetListOut) :-
        removeCardsFromList(Set, TableCards, TableCardsOut),
        getAllSubsets(TableCardsOut, SubsetListOut).

/**
Clause Name: selectCard
Purpose: Selects a card from a list given an idx.
Parameters: 
    HumanHandBeforeMove/ComputerHandBeforeMove, List containing all cards in a player's hand.
    Card, Variable to be instantiated to card selected.
    Input, Integer input value to pull card from list.
**/
selectCard(_, _, -1).
selectCard([], _, _).
selectCard(HumanHandBeforeMove, Card, Input) :- nth0(Input, HumanHandBeforeMove, Card).
selectCard(ComputerHandBeforeMove, Card, Input) :- nth0(Input, ComputerHandBeforeMove, Card).

/**
Clause Name: removeCardFromList
Purpose: Removes given Card from list.
Parameters:
    Card, Card to be removed from list.
    [Card | Rest], To see if card is the first element in list
**/
removeCardFromList(Card, [Card | Rest], Rest).
removeCardFromList(Card, [X | Rest], [X | Rest1]) :- removeCardFromList(Card, Rest, Rest1).

removeCardsFromList([], TableCardsBeforeMove, TableCardsAfterMove) :- TableCardsAfterMove = TableCardsBeforeMove.
removeCardsFromList(CapturedCards, TableCardsBeforeMove, TableCardsAfterMove) :-
        subtract(TableCardsBeforeMove, CapturedCards, TableCardsAfterMove).

/**
Clause Name: removeSetsFromList
Purpose: Remove captured builds from set of current builds, can be extended later for set capture
Parameters:
    CapturedBuilds, List of Builds selected for capture.
    BuildsBeforeMove, List of current Builds in the game.
    BuildsAfterMove, Uninstantiated variable that will contain list of current builds after captured ones are removed.
**/
removeSetsFromList([], BuildsBeforeMove, BuildsAfterMove) :-
        BuildsAfterMove = BuildsBeforeMove.

removeSetsFromList(CapturedBuilds, BuildsBeforeMove, BuildsAfterMove) :-
        [B1 | Rest] = CapturedBuilds,
        removeSetFromList(B1, BuildsBeforeMove, [], NewBuilds),
        removeSetsFromList(Rest, NewBuilds, BuildsAfterMove).

/**
Clause Name: removeSetFromList
Purpose: Called by removeSetsFromList to remove each individual set from the list.
Parameters: 
    Build, Build selected for capture.
    BuildsBeforeMove, List of current Builds in the game.
    BuildsAfterMove, Uninstantiated variable that will contain list of current builds after captured ones are removed.
    FinalBuilds, Uninstantiated variable used to pass the updated BuildsAfterMove variable through.
**/
removeSetFromList(Build, BuildsBeforeMove, BuildsAfterMove, FinalBuilds) :-
        BuildsBeforeMove = [],
        FinalBuilds = BuildsAfterMove.

removeSetFromList(Build, BuildsBeforeMove, BuildsAfterMove, FinalBuilds) :-
        [Set | Rest] = BuildsBeforeMove,
        Build = Set,
        removeSetFromList(Build, Rest, BuildsAfterMove, FinalBuilds).

removeSetFromList(Build, BuildsBeforeMove, BuildsAfterMove, FinalBuilds) :-
        [NB | Rest] = BuildsBeforeMove,
        append(BuildsAfterMove, [NB], NewBuilds),
        removeSetFromList(Build, Rest, NewBuilds, FinalBuilds).

/**
Clause Name: getSetValue
Purpose: Get the sum value of a set of cards.
Parameters: 
    CardList, List of cards in the set.
    Value, Variable used to sum cards.
    FinalVal, Uninstantiated variable used to pass the updated Value through.
**/
getSetValue([], Value, FinalVal) :- FinalVal = Value.
getSetValue(CardList, Value, FinalVal) :-
        [Card | Rest] = CardList,
        (_, Type) = Card,
        Type = a,
        NewVal is Value + 1,
        getSetValue(Rest, NewVal, FinalVal).

getSetValue(CardList, Value, FinalVal) :-
        [Card | Rest] = CardList,
        getValue(Card, CardVal),
        NewVal is Value + CardVal,
        getSetValue(Rest, NewVal, FinalVal).

/**
Clause Name: getBuildValue
Purpose: Get the sum value of a build.
Parameters:
        Build, Build to get value of.
        FinalVal, Uninstantiated var to pass computed value back through the clause. 
**/
getBuildValue(Build, FinalVal) :-
        [Set | _] = Build,
        getSetValue(Set, 0, FinalVal).

/**
Clause Name: removeBuildOwners
Purpose: Locates and removes build owners from list after a build is captured.
Parameters:
        CapturedBuilds, List of builds selected for capture by player.
        BuildsBeforeMove, List of current builds on the table before capture move is made.
        BuildOwners, List of current build owners.
        NewBuildOwners, Uninstantiated variable to pass new list of build owners through.
**/
removeBuildOwners(CapturedBuilds, BuildsBeforeMove, BuildOwners, NewBuildOwners) :-
        CapturedBuilds = [],
        NewBuildOwners = BuildOwners.

removeBuildOwners(CapturedBuilds, BuildsBeforeMove, BuildOwners, NewBuildOwners) :-
        [B1 | Rest] = CapturedBuilds,
        indexOf(BuildsBeforeMove, B1, Index),
        nth0(Index, BuildOwners, _, RemainingBuildOwners),
        removeBuildOwners(Rest, BuildsBeforeMove, RemainingBuildOwners, NewBuildOwners).
        

/**
Clause Name: getPlayerHands
Purpose: Given a current player and a list of cards after move is made, determine whether to update the computer player or the human players hand.
Parameters:
        State, List of variables in game state,
        CurrentPlayer, player who is currently playing,
        HandAfterMove, List of cards in player's hand after move is made.
        HumanHand, Uninstantiated var to track list of cards in human's hand.
        ComputerHand, Uninstantiated var to track list of cards in computer's hand.
**/
getPlayerHands(State, CurrentPlayer, HandAfterMove, HumanHand, ComputerHand) :-
        CurrentPlayer = human,
        HumanHand = HandAfterMove,
        getComputerHandFromState(State, ComputerHand).

getPlayerHands(State, CurrentPlayer, HandAfterMove, HumanHand, ComputerHand) :-
        CurrentPlayer = computer,
        ComputerHand = HandAfterMove,
        getHumanHandFromState(State, HumanHand).

/**
Clause Name: getPlayerPiles
Purpose: Given a current player and a list of cards after move is made, determine whether to update the computer player or the human players pile.
Parameters:
        State, List of variables in game state,
        CurrentPlayer, player who is currently playing,
        PileAfterMove, List of cards in player's pile after move is made.
        HumanPile, Uninstantiated var to track list of cards in human's pile.
        ComputerPile, Uninstantiated var to track list of cards in computer's pile.
**/
getPlayerPiles(State, CurrentPlayer, PileAfterMove, HumanPile, ComputerPile) :-
        CurrentPlayer = human,
        HumanPile = PileAfterMove,
        getComputerPileFromState(State, ComputerPile).

getPlayerPiles(State, CurrentPlayer, PileAfterMove, HumanPile, ComputerPile) :-
        CurrentPlayer = computer,
        ComputerPile = PileAfterMove,
        getHumanPileFromState(State, HumanPile).

/**
Clause Name: validateTrail
Purpose: Check whether trail move can be made with selected card. Temporarily allows computer to bypass for testing.
Parameters:
        State, List of variables in game state.
        CardSelected, Card selected to be trailed by player.
        TableCards, List of cards on the table to check against.
        BuildOwners, List of build owners.
        CurrentPlayer, Player currently making move.
**/
validateTrail(State, CardSelected, TableCards, BuildOwners, CurrentPlayer) :-
        CurrentPlayer = computer.
validateTrail(State, CardSelected, TableCards, BuildOwners, CurrentPlayer) :-
        checkMatchingLooseCards(State, CardSelected, TableCards),
        checkBuildOwnership(State, BuildOwners, CurrentPlayer).

/**
Clause Name: checkMatchingLooseCards
Purpose: Check whether there are any matching loose cards on the table.
Parameters:
        State, List of variables in game state.
        Type, Type of card selected to trail.
        TableCards, List of cards on the table.
**/
checkMatchingLooseCards(State, (_, Type), []).
checkMatchingLooseCards(State, (_, Type), TableCards) :-
        [TableCard | Rest] = TableCards,
        (_, TableCardType) = TableCard,
        assessType(State, Type, TableCardType),
        checkMatchingLooseCards(State, (_, Type), Rest).

/**
Clause Name: assessType
Purpose: Checks if type of card selected is equal to type of card on table. Prints error message and restarts round if true.
Parameters:
        State, List of variables in game state.
        PlayedType, Type of card selected for trail.
        TableCardType, Type of card on table.
**/
assessType(State, PlayedType, TableCardType) :-
        PlayedType \= TableCardType.

assessType(State, PlayedType, TableCardType) :-
        Type = TableCardType,
        write('Trail move cannot be made. Matching loose card exists.'), nl,
        playRound(State).

/**
Clause Name: checkBuildOwnership
Purpose: Checks to see if player currently owns a build.
Parameters:
        State, List of variables in game state.
        BuildOwners, List of current build owners.
        CurrentPlayer, identity of player currently making move.
**/
checkBuildOwnership(State, [], CurrentPlayer).
checkBuildOwnership(State, BuildOwners, CurrentPlayer) :-
        [Owner | Rest] = BuildOwners,
        assessOwnership(State, Owner, CurrentPlayer),
        checkBuildOwnership(State, Rest, CurrentPlayer).

/**
Clause Name: assessOwnership
Purpose: Checks to see if player is build owner, prints error message and restarts round if true.
Parameters:
        State, List of variables in game state.
        BuildOwner, Owner of build on table.
        CurrentPlayer, identity of player currently making move to check against BuildOwner.
**/
assessOwnership(State, BuildOwner, CurrentPlayer) :-
        BuildOwner \= CurrentPlayer.
assessOwnership(State, BuildOwner, CurrentPlayer) :-
        BuildOwner = CurrentPlayer,
        write('Trail move cannot be made. You currently own a build.'), nl,
        playRound(State).