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
        Input == y,
        loadGame().

loadOrNew(Input) :- 
        Input == n,
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
        shuffleDeck(NewGameDeck, GameDeckBeforeMove),
        dealCards(GameDeckBeforeMove, HumanHandBeforeMove, HNewGameDeck),
        dealCards(HNewGameDeck, ComputerHandBeforeMove, CNewGameDeck),
        dealCards(CNewGameDeck, TableCardsBeforeMove, TNewGameDeck),
        RoundNum = 0,
        HumanScore = 0,
        ComputerScore = 0,
        NextPlayer = human,
        HumanPile = [],
        ComputerPile = [],
        Builds = [],
        State = [RoundNum, TNewGameDeck, HumanScore, HumanHandBeforeMove, HumanPile, ComputerScore, ComputerHandBeforeMove, ComputerPile, Builds, TableCardsBeforeMove, NextPlayer],
        printBoard(State, HumanPile, HumanHandBeforeMove, TableCardsBeforeMove, ComputerPile, ComputerHandBeforeMove),                    
        playRound(State).

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
        getTableCardsFromState(State, TableCardsBeforeMove),
        getHumanHandFromState(State, HumanHandBeforeMove),
        getComputerHandFromState(State, ComputerHandBeforeMove),
        getDeckFromState(State, NewGameDeck),
        checkHandsEmpty(HumanHandBeforeMove, HumanHandAfterCheck, ComputerHandBeforeMove, ComputerHandAfterCheck, NewGameDeck, GameDeck),
        printBoard(State, HumanPileBeforeMove, HumanHandAfterCheck, TableCardsBeforeMove, ComputerPileBeforeMove, ComputerHandAfterCheck),
        getMove(State, BuildsBeforeMove, BuildsAfterMove, NextPlayer, TableCardsBeforeMove, HumanHandAfterCheck, ComputerHandAfterCheck, HumanHand, ComputerHand, TableCards, HumanPileAfterMove, ComputerPileAfterMove).

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
        dealHumanCards(GameDeck, NewHumanHand, HNewGameDeck),
        dealComputerCards(HNewGameDeck, NewComputerHand, CNewGameDeck).
                                    
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
Function Name: printBoard
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
        printWhoseTurn(NewNextPlayer),
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
        write("--------------------------------"),
        nl.

/**
Function Name: printSets
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
Function Name: printBuilds
Purpose: Print current builds on table.
Parameters: Builds, List of current builds.
**/
printBuilds([]).

printBuilds(Builds) :-
    [B1 | Rest] = Builds,
    write("[ "), printCards(B1), write("] "),
    printBuilds(Rest).

/**
Function Name: printWhoseTurn
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
Function Name: getMove
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
        trail(Card, TableCardsBeforeMove, TableCardsAfterMove, ComputerHandBeforeMove, ComputerHandAfterMove).

/**
Function Name: makeMove
Purpose: Make move given user's move selection.
Parameters:
    MoveInput, Move selected by player
    TableCardsBeforeMove, List of cards on table before move is made.
    TableCardsAfterMove, Variable to be instantiated to list of cards on table after move is made.
    HumanHandBeforeMove, List of cards in player's hand.
    HumanHandAfterMove, Variable to be instantiated to list of cards in hand after move is made.
**/
makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput == trail,
        write("Select the idx of card in your hand: "),
        printCards(HumanHandBeforeMove),
        read(Input),
        write("Human making move."), nl,
        selectCard(HumanHandBeforeMove, Card, Input),
        trail(Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove).

makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput == capture,
        write("Select the idx of card in your hand: "),
        printCards(HumanHandBeforeMove),
        read(Input),
        write("Human making move."), nl,
        selectCard(HumanHandBeforeMove, Card, Input), 
        capture(State, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove, BuildsBeforeMove, BuildsAfterMove).

makeMove(State, BuildsBeforeMove, BuildsAfterMove, MoveInput, Card, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, HumanPileBeforeMove, HumanPileAfterMove) :-
        MoveInput == build,
        write("Select the card you want to sum the build to: "),
        printCards(HumanHandBeforeMove),
        read(Input1),
        write("Select the card you want to play into a build: "),
        printCards(HumanHandBeforeMove),
        read(Input2),
        selectCard(HumanHandBeforeMove, CardSelected, Input1),
        selectCard(HumanHandBeforeMove, CardPlayed, Input2),
        build(CardSelected, CardPlayed, TableCardsBeforeMove, TableCardsAfterMove, HumanHandBeforeMove, HumanHandAfterMove, BuildsBeforeMove, BuildsAfterMove),
        BuildsBeforeMove \= BuildsAfterMove,
        HumanPileAfterMove = HumanPileBeforeMove.

