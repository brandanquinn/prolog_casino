/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************/

:-style_check(-singleton).

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
Clause Name: getRoundNumFromState
Purpose: Pulls the RoundNum from the State List
Parameters:
    State, List containing all variables relevant to game play.
    RoundNum, Variable to be instantiated to RoundNum from State.
**/
getRoundNumFromState(State, _) :- State = [].
getRoundNumFromState(State, RoundNum) :- nth0(0, State, RoundNum).

/**
Clause Name: getDeckFromState
Purpose: Pulls the GameDeck from the State List
Parameters:
    State, List containing all variables relevant to game play.
    NewGameDeck, Variable to be instantiated to GameDeck from State.
**/
getDeckFromState(State, _) :- State = [].
getDeckFromState(State, NewGameDeck) :- nth0(1, State, NewGameDeck).

/**
Clause Name: getHumanScoreFromState
Purpose: Pulls the human score from the State List
Parameters:
    State, List containing all variables relevant to game play.
    HumanScore, Variable to be instantiated to HumanScore from State.
**/
getHumanScoreFromState(State, _) :- State = [].                   
getHumanScoreFromState(State, HumanScore) :- nth0(2, State, HumanScore).

/**
Clause Name: getHumanHandFromState
Purpose: Pulls the HumanHand from the State List
Parameters:
    State, List containing all variables relevant to game play.
    HumanHand, Variable to be instantiated to HumanHand from State.
**/
getHumanHandFromState(State, _) :- State = [].
getHumanHandFromState(State, HumanHand) :- nth0(3, State, HumanHand).

/**
Clause Name: getHumanPileFromState
Purpose: Pulls the HumanPile from the State List
Parameters:
    State, List containing all variables relevant to game play.
    HumanPile, Variable to be instantiated to HumanPile from State.
**/
getHumanPileFromState(State, _) :- State = [].
getHumanPileFromState(State, HumanPile) :- nth0(4, State, HumanPile).

/**
Clause Name: getComputerScoreFromState
Purpose: Pulls the ComputerScore from the State List
Parameters:
    State, List containing all variables relevant to game play.
    ComputerScore, Variable to be instantiated to ComputerScore from State.
**/
getComputerScoreFromState(State, _) :- State = [].
getComputerScoreFromState(State, ComputerScore) :- nth0(5, State, ComputerScore).

/**
Clause Name: getComputerHandFromState
Purpose: Pulls the ComputerHand from the State List
Parameters:
    State, List containing all variables relevant to game play.
    ComputerHand, Variable to be instantiated to ComputerHand from State.
**/
getComputerHandFromState(State, _) :- State = [].
getComputerHandFromState(State, ComputerHand) :- nth0(6, State, ComputerHand).

/**
Clause Name: getComputerPileFromState
Purpose: Pulls the ComputerPile from the State List
Parameters:
    State, List containing all variables relevant to game play.
    ComputerPile, Variable to be instantiated to ComputerPile from State.
**/
getComputerPileFromState(State, _) :- State = [].
getComputerPileFromState(State, ComputerPile) :- nth0(7, State, ComputerPile).

/**
Clause Name: getBuildsFromState
Purpose: Pulls the Builds from the State List
Parameters:
    State, List containing all variables relevant to game play.
    Builds, Variable to be instantiated to Builds from State.
**/
getBuildsFromState(State, _) :- State = [].
getBuildsFromState(State, Builds) :- nth0(8, State, Builds).

/**
Clause Name: getBuildOwnersFromState
Purpose: Pulls the BuildOwners List var from the State List
Parameters:
        State, List containing all variables relevant to game play.
        BuildOwners, Variable to be instantiated to BuildOwners from State.
**/
getBuildOwnersFromState(State, _) :- State = [].
getBuildOwnersFromState(State, BuildOwners) :- nth0(9, State, BuildOwners).

/**
Clause Name: getTableCardsFromState
Purpose: Pulls the TableCards from the State List
Parameters:
    State, List containing all variables relevant to game play.
    TableCards, Variable to be instantiated to TableCards from State.
**/
getTableCardsFromState(State, _) :- State = [].
getTableCardsFromState(State, TableCards) :- nth0(10, State, TableCards).

/**
Clause Name: getPlayNextFromState
Purpose: Pulls the NextPlayer from the State List
Parameters:
    State, List containing all variables relevant to game play.
    NewNextPlayer, Variable to be instantiated to NextPlayer from State.
**/
getPlayNextFromState(State, _) :- State = [].
getPlayNextFromState(State, NewNextPlayer) :- nth0(11, State, NewNextPlayer).


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
Clause Name: printCards
Purpose: Print the entirety of a card list 
Parameters: Accepts a list
Algorithm:
    1. If list param is empty, do nothing.
    2. Else: 
        a. print the card on top of the cards
        b. recursively call printCards with the rest of the cards.
**/
printCards([]).
printCards([Top | Rest]) :- Top = (Suit, Type),
                            write(Suit),
                            write(Type),
                            write(" "),
                            printCards(Rest).

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
Clause Name: draw
Purpose: Draw a Card from the top of the deck.
Parameters: Takes an uninstantiated Card variable and a Deck List
Algorithm: Pulls the top card from the Deck List and assigns it to the Card variable.
**/
draw(Card, GameDeck, NewGameDeck) :- GameDeck = [Card | Rest],
                                    NewGameDeck = Rest.


/**
Clause Name: start
Purpose: Starts the game flow. Allows user to input 
**/
start() :- 
        write("Would you like to load a saved game?(y/n): "),
        read(Input),
        loadOrNew(Input).

/**
Clause Name: loadOrNew
Purpose: Parse user input and load saved game, start new tournament, or re-prompt user if they enter invalid input.
**/
loadOrNew(Input) :- 
        Input = y,
        loadGame().

loadOrNew(Input) :- 
        Input = n,
        startNewTournament().

loadOrNew(_) :- 
        write("Invalid input."), nl,
        start().

/**
Clause Name: loadGame
Purpose: Load a saved game state
**/
loadGame() :- write("Placeholder.").

/**
Clause Name: startNewTournament
Purpose: Begins a new tournament and creates new round.
Algorithm: Create game state list and initialize necessary variables.
**/
startNewTournament() :- setupRound().
startNewTournament() :- write("Failed to start new tournament.").

/**
Clause Name: setupRound
Purpose: Initializes new round.
Algorithm: Shuffle deck, deal cards and create initial game state list.
**/
setupRound() :- 
        write("Call the coin toss to go first! (h/t): "),
        read(CoinTossInput),
        coinToss(CoinTossInput, NextPlayer),
        shuffleDeck(NewGameDeck, GameDeckBeforeMove),
        dealCards(GameDeckBeforeMove, HNewGameDeck, HumanHandBeforeMove),
        dealCards(HNewGameDeck, CNewGameDeck, ComputerHandBeforeMove),
        dealCards(CNewGameDeck, TNewGameDeck, TableCardsBeforeMove),
        RoundNum = 0,
        HumanScore = 0,
        ComputerScore = 0,
        HumanPile = [],
        ComputerPile = [],
        Builds = [],
        BuildOwners = [],
        State = [RoundNum, TNewGameDeck, HumanScore, HumanHandBeforeMove, HumanPile, ComputerScore, ComputerHandBeforeMove, ComputerPile, Builds, BuildOwners, TableCardsBeforeMove, NextPlayer],
        printBoard(State, HumanPile, HumanHandBeforeMove, TableCardsBeforeMove, ComputerPile, ComputerHandBeforeMove),                    
        playRound(State).

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
        write("Invalid input for coin toss. Try again."), nl,
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
        write("Congrats, you won the coin toss!"), nl,
        NextPlayer = human.

assessCall(_, _, NextPlayer) :-
        write("Unfortunately you've lost the coin toss."), nl,
        NextPlayer = computer.

/**
Clause Name: playRound
Purpose: Begin playing current round
Parameters: State, List containing all variables relevant to game play.
**/
playRound(State) :-
        getHumanPileFromState(State, HumanPileBeforeMove),
        getComputerPileFromState(State, ComputerPileBeforeMove),
        getRoundNumFromState(State, RoundNum),
        getHumanScoreFromState(State, HumanScore),
        getComputerScoreFromState(State, ComputerScore),
        getBuildsFromState(State, BuildsBeforeMove),
        getBuildOwnersFromState(State, BuildOwners),
        getTableCardsFromState(State, TableCardsBeforeMove),
        getHumanHandFromState(State, HumanHandBeforeMove),
        getComputerHandFromState(State, ComputerHandBeforeMove),
        getDeckFromState(State, NewGameDeck),
        getPlayNextFromState(State, NextPlayer),
        checkHandsEmpty(HumanHandBeforeMove, HumanHandAfterCheck, ComputerHandBeforeMove, ComputerHandAfterCheck, NewGameDeck, GameDeck),
        NewState = [RoundNum, GameDeck, HumanScore, HumanHandAfterCheck, HumanPileBeforeMove, ComputerScore, ComputerHandAfterCheck, ComputerPileBeforeMove, BuildsBeforeMove, BuildOwners, TableCardsBeforeMove, NextPlayer],
        printBoard(NewState, HumanPileBeforeMove, HumanHandAfterCheck, TableCardsBeforeMove, ComputerPileBeforeMove, ComputerHandAfterCheck),
        getMove(NewState, BuildsBeforeMove, BuildsAfterMove, NextPlayer, TableCardsBeforeMove, HumanHandAfterCheck, ComputerHandAfterCheck, HumanHand, ComputerHand, TableCards, HumanPileAfterMove, ComputerPileAfterMove).

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
Clause Name: printBoard
Purpose: Prints the current board using lists from State
Parameters:
    NewHumanHand, List containing cards in human's hand..
    NewTableCards, List containing cards on the table.
    NewComputerHand, List containing cards in computer's hand.
**/
printBoard(State, HumanPile, HumanHand, TableCards, ComputerPile, ComputerHand) :- 
        write("--------------------------------"), nl,
        getPlayNextFromState(State, NewNextPlayer),
        getBuildsFromState(State, Builds),
        getBuildOwnersFromState(State, BuildOwners),
        printWhoseTurn(NewNextPlayer),
        getHumanScoreFromState(State, HumanScore),
        getComputerScoreFromState(State, ComputerScore),
        write("Human Score: "),
        write(HumanScore), nl,
        write("Human Pile: "),
        printCards(HumanPile),
        nl,
        write("Human Cards: "),
        printCards(HumanHand),
        nl,
        write("Table Cards: "),
        printBuilds(Builds),
        printCards(TableCards),
        nl,
        write("Computer Cards: "),
        printCards(ComputerHand),
        nl,
        write("Computer Pile: "),
        printCards(ComputerPile),
        nl,
        write("Computer Score: "),
        write(ComputerScore), nl,
        write("Build Owners: "),
        printBuildOwners(Builds, BuildOwners), nl,
        write("--------------------------------"),
        nl.

/**
Clause Name: printSets
Purpose: Print Sets of cards.
Parameters: Sets, List of sets of cards.
**/
printSets([[]]).

printSets([]).

printSets(Sets) :-
        [Set | Rest] = Sets,
        printCards(Set),
        printSets(Rest).

/**
Clause Name: printBuilds
Purpose: Print current builds on table.
Parameters: Builds, List of current builds.
**/
printBuilds([]).

printBuilds(Builds) :-
        [B1 | Rest] = Builds,
        printOpenBracketIfMB(B1),
        printBuild(B1),
        printClosedBracketIfMB(B1),
        printBuilds(Rest).

/**
Clause Name: printOpenBracketIfMB
Purpose: Prints an extra open bracket if build being printed is a multi-build.
Parameters: Build, Build being printed.
**/
printOpenBracketIfMB(Build) :-
        length(Build, 1).
printOpenBracketIfMB(_) :-
        write("[ ").

/**
Clause Name: printClosedBracketIfMB
Purpose: Prints an extra closed bracket if build being printed is a multi-build.
Parameters: Build, Build being printed.
**/
printClosedBracketIfMB(Build) :-
        length(Build, 1).
printClosedBracketIfMB(_) :-
        write("] ").

/**
Clause Name: printBuild
Purpose: Prints the contents of a build set.
Parameters: Build, Build being printed.
**/
printBuild([]).

printBuild(Build) :-
        [Set | Rest] = Build,
        write("[ "), printCards(Set), write("] "),
        printBuild(Rest). 

/**
Clause Name: printBuildOwners
Purpose: Print builds and their owners
Parameters: 
        Builds, List of current builds.
        BuildOwners, List of current build owners.
**/
printBuildOwners([], []).

printBuildOwners(Builds, BuildOwners) :-
        [B1 | RestOfBuilds] = Builds,
        [Owner1 | RestOfOwners] = BuildOwners,
        printOpenBracketIfMB(B1),
        printBuild(B1),
        printClosedBracketIfMB(B1),
        write(Owner1), write(" "),
        printBuildOwners(RestOfBuilds, RestOfOwners).

/**
Clause Name: printWhoseTurn
Purpose: Prints whose turn it is.
Parameters: NewNextPlayer, Variable containing whose turn it is.
**/
printWhoseTurn(NewNextPlayer) :- 
        NewNextPlayer = human,
        write("Human player's turn."), nl.
printWhoseTurn(NewNextPlayer) :- 
        NewNextPlayer = computer,
        write("Computer player's turn."), nl.
printWhoseTurn(_) :- write("Unknown Turn"), nl.   

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
        getPlayNextFromState(State, NewNextPlayer),
        NewNextPlayer = human,
        write("What move would you like to make?"), nl,
        write("(capture, build, increase, trail, save, deck, or exit): "),
        read(MoveInput),
        getHumanPileFromState(State, HumanPileBeforeMove),
        getComputerPileFromState(State, ComputerPileAfterMove),
        makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove).

% Computer move
getMove(State, BuildsBeforeMove, BuildsAfterMove, NextPlayer, TableCardsBeforeMove, HumanHandBeforeMove, ComputerHandBeforeMove, HumanHandAfterMove, ComputerHandAfterMove, TableCardsAfterMove, HumanPileAfterMove, ComputerPileAfterMove) :- 
        getPlayNextFromState(State, NewNextPlayer),
        NewNextPlayer = computer,
        write("Computer making move."), nl,
        selectCard(ComputerHandBeforeMove, Card, 0),
        trail(State, Card, TableCardsBeforeMove, TableCardsAfterMove, ComputerHandBeforeMove, ComputerHandAfterMove).

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
        write("Select the idx of card in your hand: "),
        printCards(HumanHandBeforeMove),
        read(Input),
        write("Human making move."), nl,
        selectCard(HumanHandBeforeMove, Card, Input),
        trail(State, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove).

makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput = capture,
        write("Select the idx of card in your hand: "),
        printCards(HumanHandBeforeMove),
        read(Input),
        write("Human making move."), nl,
        selectCard(HumanHandBeforeMove, Card, Input), 
        capture(State, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove, BuildsBeforeMove, BuildsAfterMove).

makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput = build,
        write("Select the card you want to sum the build to: "),
        printCards(HumanHandBeforeMove),
        read(Input1),
        write("Select the card you want to play into a build: "),
        printCards(HumanHandBeforeMove),
        read(Input2),
        selectCard(HumanHandBeforeMove, CardSelected, Input1),
        selectCard(HumanHandBeforeMove, CardPlayed, Input2),
        build(State, CardSelected, CardPlayed, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, BuildsBeforeMove, BuildsAfterMove).

makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput = increase,
        write("Select the card you want to sum the increased build to: "),
        printCards(HumanHandBeforeMove),
        read(Input1),
        write("Select the card you want to play into the build: "),
        printCards(HumanHandBeforeMove),
        read(Input2),
        selectCard(HumanHandBeforeMove, CardSelected, Input1),
        selectCard(HumanHandBeforeMove, CardPlayed, Input2),
        increase(State, CardSelected, CardPlayed, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, BuildsBeforeMove, BuildsAfterMove).

makeMove(_, _, _, MoveInput, _, _, _, _, _, _, _) :-
        MoveInput = exit,
        write("Thanks for playing! Exiting game."), nl,
        halt().

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
        write("Select the card you want to add to set: "),
        printCards(NewTableCards),
        read(NewInput),
        getSelection(NewTableCards, NewCardsSelected, FinalCardsSelected, NewInput).


getSelection(TableCardsBeforeMove, TableCardsForBuild, FinalCardsSelected, Input) :-
        selectCard(TableCardsBeforeMove, TableCardSelected, Input),
        append(TableCardsForBuild, [TableCardSelected], NewCardsSelected),
        removeCardFromList(TableCardSelected, TableCardsBeforeMove, NewTableCards),
        write("Cards currently selected: "), printCards(NewCardsSelected), nl,
        write("Select the card(s) you want to add to set: "),
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
        write("Select the card you want to add to set for capture: "),
        printCards(TableCardsBeforeMove),
        read(Input),
        getSelection(TableCardsBeforeMove, [], FinalCardsSelected, Input),
        write("Cards selected from table: "), printCards(FinalCardsSelected), nl.

/**
Clause Name: getTableCardsForBuild
Purpose: Wrapper to get cards selected for build by user.
Parameters:
    TableCardsBeforeMove, List of cards to be selected from the table.
    FinalCardsSelected, List of cards selected by user.
**/
getTableCardsForBuild(TableCardsBeforeMove, FinalCardsSelected) :-
        write("Select the card you want to build with: "),
        printCards(TableCardsBeforeMove),
        read(Input),
        getSelection(TableCardsBeforeMove, [], FinalCardsSelected, Input),
        write("Cards selected from table: "), printCards(FinalCardsSelected), nl.

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
Clause Name: flattenList
Purpose: Flatten a 2d list of cards.
Parameters:
    BigList, 2d List of cards to flatten.
    FlatListBefore, temp variable to add cards to.
    FlatListAfter, Variable to pipe flattened list through.
**/
flattenList([], FlatListBefore, FlatListAfter) :-
        FlatListAfter = FlatListBefore.

flattenList(BigList, FlatListBefore, FlatListAfter) :-
        [Set | Rest] = BigList,
        append(FlatListBefore, Set, NewList),
        flattenList(Rest, NewList, FlatListAfter).

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

getBuildValue(Build, FinalVal) :-
        [Set | _] = Build,
        getSetValue(Set, 0, FinalVal).

/**
Clause Name: indexOf
Purpose: Finds index of a given element in a list, Index of -1 provided if element not found.
Parameters:
        List, Given list to locate element.
        Element, Element we are looking for.
        Index, Uninstantiated variable to give index.
**/
indexOf([Element | _], Element, 0). % We found the element

indexOf([_ | Rest], Element, Index):-
        indexOf(Rest, Element, Index1),
        Index is Index1 + 1.

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
        write("Player has selected to trail:"), printCards([Card]), nl,     
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanScoreFromState(State, HumanScore),
        getHumanPileFromState(State, HumanPile),
        getComputerScoreFromState(State, ComputerScore),
        getComputerPileFromState(State, ComputerPile),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        getPlayerHands(State, CurrentPlayer, HandAfterMove, HumanHand, ComputerHand),
        getBuildsFromState(State, Builds),
        NewState = [RoundNum, GameDeck, HumanScore, HumanHand, HumanPile, ComputerScore, ComputerHand, ComputerPile, Builds, BuildOwners, TableCardsAfterMove, NextPlayer],
        playRound(NewState).

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
        write("Trail move cannot be made. Matching loose card exists."), nl,
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
        write("Trail move cannot be made. You currently own a build."), nl,
        playRound(State).

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
build(State, CardSelected, CardPlayed, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, BuildsBeforeMove, BuildsAfterMove) :-
        BuildsBeforeMove \= [],
        getPlayNextFromState(State, CurrentPlayer),
        getBuildOwnersFromState(State, BuildOwners),
        extendingBuild(CardSelected, CurrentPlayer, BuildsBeforeMove, BuildOwners, BuildFound),
        write("Player has selected to extend this build: "), printBuilds([BuildFound]),
        write("to a multiple build by playing card: "), printCards([CardPlayed]), nl,
        getTableCardsForBuild(TableCardsBeforeMove, FinalCardsSelected),
        append(FinalCardsSelected, [CardPlayed], BuildCardList),
        getSetValue(BuildCardList, 0, BuildVal),
        validateBuildCreated(State, BuildVal, SelectedValue),
        write("Creating build of: [ "), printBuilds([BuildFound, [BuildCardList]]), write("]"), nl,
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
        whosPlayingNext(CurrentPlayer, NextPlayer),
        NewState = [RoundNum, GameDeck, HumanScore, HumanHandAfterMove, HumanPile, ComputerScore, ComputerHand, ComputerPile, BuildsAfterMove, BuildOwners, TableCardsAfterMove, NextPlayer],
        playRound(NewState).
        
build(State, CardSelected, CardPlayed, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, BuildsBeforeMove, BuildsAfterMove) :-
        getValue(CardSelected, SelectedValue),
        getValue(CardPlayed, PlayedValue),
        getTableCardsForBuild(TableCardsBeforeMove, FinalCardsSelected),
        append(FinalCardsSelected, [CardPlayed], BuildCardList),
        getSetValue(BuildCardList, 0, BuildVal),
        validateBuildCreated(State, BuildVal, SelectedValue),
        write("Creating build of: [ "), printCards(BuildCardList), write("]"), nl,
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
        whosPlayingNext(CurrentPlayer, NextPlayer),
        NewState = [RoundNum, GameDeck, HumanScore, HumanHandAfterMove, HumanPile, ComputerScore, ComputerHand, ComputerPile, BuildsAfterMove, NewBuildOwners, TableCardsAfterMove, NextPlayer],
        playRound(NewState).

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
        write("Build cannot be created. Set of cards selected totals to: "),
        write(BuildVal),
        write(". Needs to total to: "),
        write(SelectedValue), nl,
        playRound(State).

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

checkBuildEquality(Build, _, NewBuild, BuildOut) :- BuildOut = [Build].

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
increase(State, CardSelected, CardPlayed, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, BuildsBeforeMove, BuildsAfterMove) :-
        getValue(CardSelected, SelectedValue),
        getValue(CardPlayed, PlayedVal),
        getBuildSelection(State, SelectedValue, PlayedVal, BuildsBeforeMove, BuildToIncrease),
        write("Selected to increase build: "), printBuilds([BuildToIncrease]),
        write(". By playing card: "), printCards([CardPlayed]), nl,
        % make sure build is owned by opponent
        getPlayNextFromState(State, CurrentPlayer),
        getBuildOwnersFromState(State, BuildOwners),
        validateBuild(State, BuildToIncrease, BuildsBeforeMove, BuildOwners, CurrentPlayer),
        % update build
        indexOf(BuildsBeforeMove, BuildToIncrease, IndexOfBuild),
        increaseBuild(CardPlayed, BuildToIncrease, IndexOfBuild, CurrentPlayer, BuildOwners, IncreasedBuild, NewBuildOwners),
        write("New build of: "), printBuilds([IncreasedBuild]),
        write(". Has been created and is now owned by: "), write(CurrentPlayer), nl,
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
        NewState = [RoundNum, GameDeck, HumanScore, HumanHandAfterMove, HumanPile, ComputerScore, ComputerHand, ComputerPile, BuildsAfterMove, NewBuildOwners, TableCardsBeforeMove, NextPlayer],
        playRound(NewState).

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
getBuildSelection(State, SelectedValue, PlayedVal, BuildsBeforeMove, BuildToIncrease) :-
        getBuildForUser(State, BuildsBeforeMove, BuildSelected),
        getSetValue(BuildSelected, 0, BuildVal),
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
        write("Which build would you like to increase?: "),
        printBuilds(BuildsBeforeMove),
        read(BuildInput),
        assessBuildInput(State, BuildsBeforeMove, BuildInput, BuildSelected).

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
        write("Invalid input. Try again."), nl,
        playRound(State).

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
        write("Cannot increase build. Build with value: "),
        write(BuildVal),
        write(". With added value of: "),
        write(PlayedVal),
        write(". Does not sum to card selected: "),
        write(SelectedValue), nl,
        playRound(State).

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
        indexOf(CurrentBuilds, BuildSelected, Index), 
        nth0(Index, BuildOwners, Owner),
        checkIsOpponentsBuild(State, CurrentPlayer, Owner).

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
        write("This build belongs to you, increase move cannot be made. Try again."), nl,
        playRound(State).

/**
Clause Name: replaceElement
Purpose: Utility function to replace an element of a list and return the new list.
Parameters:
        Index, index of element you wish to replace.
        List, List of elements you wish to change.
        Element, Element that you want to replace with.
        NewList, Uninstantiated variable to contain the new list of elements.
**/
replaceElement(Index, List, Element, NewList) :-
        nth0(Index, List, _, R),
        nth0(Index, NewList, Element, R).

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
        append(BuildSelected, [CardPlayed], NewBuild),
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
capture(State, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove, BuildsBeforeMove, BuildsAfterMove) :-
        /** Same face capture **/
        getCapturableCards(TableCardsBeforeMove, Card, CapturableCardsBefore, CapturableCardsAfter),
        promptSameFaceCapture(State, CapturableCardsAfter),
        removeCardsFromList(CapturableCardsAfter, TableCardsBeforeMove, TableCardsAfterSameVal),
        write("Player has selected to capture: "), printCards(CapturableCardsAfter), write("with card:"), printCards([Card]), nl,
        /** Build capture **/
        getBuildOwnersFromState(State, BuildOwners),
        getCapturableBuilds(Card, BuildsBeforeMove, CapturableBuilds1, CapturableBuilds2),
        promptBuildCapture(CapturableBuilds2, CapturedBuilds),
        write("Player will also capture: "), printBuilds(CapturedBuilds), nl,
        % Issue here when more than one build is being captured at once.
        removeBuildOwners(CapturedBuilds, BuildsBeforeMove, BuildOwners, NewBuildOwners),
        removeSetsFromList(CapturedBuilds, BuildsBeforeMove, BuildsAfterMove),
        /** Set capture **/
        promptSetCapture(State, Card, TableCardsAfterSameVal, CapturableCardsAfter, CapturedBuilds, CapturableSets),
        write("Player will also capture via sets: "), printSets(CapturableSets), nl,
        removeSetsFromList(CapturableSets, TableCardsAfterSameVal, TableCardsAfterMove),
        append(HumanPileBeforeMove, [Card], HumanPileWithCaptureCard),
        flattenList(CapturableBuilds2, _, BuildCardsCaptured),
        addCapturedSetsToPile(BuildCardsCaptured, HumanPileWithCaptureCard, HumanPileWithBuilds),
        append(HumanPileWithBuilds, CapturableCardsAfter, HumanPileAfterSameVal),
        addCapturedSetsToPile(CapturableSets, HumanPileAfterSameVal, HumanPileAfterMove),
        removeCardFromList(Card, HumanHandBeforeMove, HumanHandAfterMove),
        getRoundNumFromState(State, RoundNum),
        getDeckFromState(State, GameDeck),
        getHumanScoreFromState(State, HumanScore),
        getComputerScoreFromState(State, ComputerScore),
        getComputerHandFromState(State, ComputerHand),
        getComputerPileFromState(State, ComputerPile),
        getPlayNextFromState(State, CurrentPlayer),
        whosPlayingNext(CurrentPlayer, NextPlayer),
        NewState = [RoundNum, GameDeck, HumanScore, HumanHandAfterMove, HumanPileAfterMove, ComputerScore, ComputerHand, ComputerPile, BuildsAfterMove, NewBuildOwners, TableCardsAfterMove, NextPlayer],
        playRound(NewState).

/**
Clause Name: promptSameFaceCapture
Purpose: Prompt a user whether or not they want to capture same face cards.
Parameters: 
        State, list of vars in game state.
        CapturableCards, List of capturable cards
**/
promptSameFaceCapture(State, CapturableCards) :- CapturableCards = [].
promptSameFaceCapture(State, CapturableCards) :-
        write("Do you want to capture the following cards? (y/n): "),
        printCards(CapturableCards),
        read(Input),
        Input = n,
        write("Must capture all same face cards on the table. Try again."), nl,
        playRound(State).

promptSameFaceCapture(State, CapturableCards).

/**
Clause Name: promptBuildCapture
Purpose: Prompt a user whether or not they want to capture builds.
Parameters:
        CapturableBuilds, list of builds that can be captured.
        CapturableBuildsAfterPrompt, uninstantiated var that will contain the list of builds captured after prompt.
**/
promptBuildCapture(CapturableBuilds, CapturableBuildsAfterPrompt) :-
        CapturableBuilds = [],
        CapturableBuildsAfterPrompt = CapturableBuilds.

promptBuildCapture(CapturableBuilds, CapturableBuildsAfterPrompt) :-
        write("Do you want to capture the following builds? (y/n): "),
        printBuilds(CapturableBuilds),
        read(Input),
        validateBuildInput(Input, CapturableBuilds, CapturableBuildsAfterPrompt).

validateBuildInput(Input, _, BuildsOut) :-
        Input = n,
        BuildsOut = [].

validateBuildInput(_, BuildsIn, BuildsOut) :-
        BuildsOut = BuildsIn.

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
        write("Would you like to select sets to capture? (y/n): "),
        read(Input),
        Input = n,
        write("No move made. Try again"), nl,
        playRound(State).

promptSetCapture(State, CardPlayed, TableCards, CapturableCards, CapturableBuilds, CapturableSets) :-
        write("Would you like to select sets to capture? (y/n): "),
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
        write("Would you like to select another set for capture? (y/n)"),
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
        write("Invalid set entered. Sum of set: "), 
        write(SetVal), 
        write(". Needed to add up to: "),
        write(PlayedVal),
        write(". Try again."), nl,
        playRound(State).