/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************/

% cards
card(Suit, Type).
card(h, 2).
card(h, 3).
card(h, 4).
card(h, 5).
card(h, 6).
card(h, 7).
card(h, 8).
card(h, 9).
card(h, x).
card(h, j).
card(h, q).
card(h, k).
card(h, a).

card(s, 2).
card(s, 3).
card(s, 4).
card(s, 5).
card(s, 6).
card(s, 7).
card(s, 8).
card(s, 9).
card(s, x).
card(s, j).
card(s, q).
card(s, k).
card(s, a).

card(d, 2).
card(d, 3).
card(d, 4).
card(d, 5).
card(d, 6).
card(d, 7).
card(d, 8).
card(d, 9).
card(d, x).
card(d, j).
card(d, q).
card(d, k).
card(d, a).

card(c, 2).
card(c, 3).
card(c, 4).
card(c, 5).
card(c, 6).
card(c, 7).
card(c, 8).
card(c, 9).
card(c, x).
card(c, j).
card(c, q).
card(c, k).
card(c, a).

/**
Function Name: deck
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
Function Name: shuffledeck
Purpose: Shuffle a Deck List and assign it to a variable
Parameters: Variable to assign shuffled deck list to.
Algorithm: 
    1. Assign pre-built deck list to Deck variable
    2. Call random_permutation() to shuffle pre-built deck list and assign the new list to ShuffledDeck variable 
**/
shuffleDeck(NewGameDeck, GameDeckBeforeMove) :- deck(NewGameDeck),
                            random_permutation(NewGameDeck, GameDeckBeforeMove).

/**
Function Name: printCards
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
printCards(_) :- write("Printing cards from uninstantiated variable."), nl.
/**
Function Name: draw
Purpose: Draw a Card from the top of the deck.
Parameters: Takes an uninstantiated Card variable and a Deck List
Algorithm: Pulls the top card from the Deck List and assigns it to the Card variable.
**/
draw(Card, GameDeck, NewGameDeck) :- GameDeck = [Card | Rest],
                                    NewGameDeck = Rest.

/**  [RoundNum, GameDeck, HumanScore, HumanHand, HumanPile, ComputerScore, ComputerHand, ComputerPile, Builds, TableCards, NextPlayer] **/

getRoundNumFromState(State, _) :- State = [].
getRoundNumFromState(State, RoundNum) :- nth0(0, State, RoundNum).

/**
Function Name: getDeckFromState
Purpose: Pulls the GameDeck from the State List
Parameters:
    State, List containing all variables relevant to game play.
    GameDeck, Variable to be instantiated to GameDeck from State.
**/
getDeckFromState(State, _) :- State = [].
getDeckFromState(State, NewGameDeck) :- nth0(1, State, NewGameDeck).

getHumanScoreFromState(State, _) :- State = [].                   
getHumanScoreFromState(State, HumanScore) :- nth0(2, State, HumanScore).

/**
Function Name: getHumanHandFromState
Purpose: Pulls the HumanHand from the State List
Parameters:
    State, List containing all variables relevant to game play.
    HumanHand, Variable to be instantiated to HumanHand from State.
**/
getHumanHandFromState(State, _) :- State = [].
getHumanHandFromState(State, HumanHand) :- nth0(3, State, HumanHand).

getHumanPileFromState(State, _) :- State = [].
getHumanPileFromState(State, HumanPile) :- nth0(4, State, HumanPile).

getComputerScoreFromState(State, _) :- State = [].
getComputerScoreFromState(State, ComputerScore) :- nth0(5, State, ComputerScore).

/**
Function Name: getComputerHandFromState
Purpose: Pulls the ComputerHand from the State List
Parameters:
    State, List containing all variables relevant to game play.
    ComputerHand, Variable to be instantiated to ComputerHand from State.
**/
getComputerHandFromState(State, _) :- State = [].
getComputerHandFromState(State, ComputerHand) :- nth0(6, State, ComputerHand).

getComputerPileFromState(State, _) :- State = [].
getComputerPileFromState(State, ComputerPile) :- nth0(7, State, ComputerPile).

getBuildsFromState(State, _) :- State = [].
getBuildsFromState(State, Builds) :- nth0(8, State, Builds).

getTableCardsFromState(State, _) :- State = [].
getTableCardsFromState(State, TableCards) :- nth0(9, State, TableCards).

getPlayNextFromState(State, _) :- State = [].
getPlayNextFromState(State, NewNextPlayer) :- nth0(10, State, NewNextPlayer).

selectCard([], _, _).
selectCard(HumanHandBeforeMove, Card, Input) :- nth0(Input, HumanHandBeforeMove, Card).
selectCard(ComputerHandBeforeMove, Card, Input) :- nth0(Input, ComputerHandBeforeMove, Card).

trail(Card, TableCardsBeforeMove, TableCards) :- TableCards = [TableCardsBeforeMove | Card].

getMove(NextPlayer, TableCardsBeforeMove, HumanHandBeforeMove, ComputerHandBeforeMove, HumanHand, ComputerHand, TableCards) :-
                                                                                    getPlayNextFromState(State, NewNextPlayer),
                                                                                    NextPlayer = NewNextPlayer,
                                                                                    NextPlayer == human,
                                                                                    write("Select the idx of card in your hand: "),
                                                                                    printCards(HumanHandBeforeMove),
                                                                                    read(Input),
                                                                                    selectCard(HumanHandBeforeMove, Card, Input),
                                                                                    trail(Card, TableCardsBeforeMove, TableCards).

printWhoseTurn(NewNextPlayer) :- NewNextPlayer == human,
                                write("Human player's turn."), nl.
printWhoseTurn(NewNextPlayer) :- NewNextPlayer == computer,
                                write("Computer player's turn."), nl.
printWhoseTurn(_) :- write("Unknown Turn"), nl.                           

/**
Function Name: printBoard
Purpose: Prints the current board using lists from State
Parameters:
    NewHumanHand, List containing cards in human's hand..
    NewTableCards, List containing cards on the table.
    NewComputerHand, List containing cards in computer's hand.
**/
printBoard(State, HumanPile, HumanHandBeforeMove, TableCardsBeforeMove, ComputerPile, ComputerHandBeforeMove) :- getPlayNextFromState(State, NewNextPlayer),
                                        printWhoseTurn(NewNextPlayer),
                                        write("Human Pile: "),
                                        printCards(HumanPile),
                                        nl,
                                        write("Human Cards: "),
                                        printCards(HumanHandBeforeMove),
                                        nl,
                                        write("Table Cards: "),
                                        printCards(TableCardsBeforeMove),
                                        nl,
                                        write("Computer Cards: "),
                                        printCards(ComputerHandBeforeMove),
                                        nl,
                                        write("Computer Pile: "),
                                        printCards(ComputerPile),
                                        nl.

/**
Function Name: dealHumanCards
Purpose: Deals 4 cards to the Human player
Parameters:
    State, List containing all variables relevant to game play.
    GameDeck, List containing all cards in the deck.
    NewHumanHand, Variable that will be instantiated to list of cards dealt to Human hand.
    HNewGameDeck, Variable that will be instantiated to new deck after cards are dealt to human.
**/
dealHumanCards(NewGameDeck, HumanHandBeforeMove, HNewGameDeck) :- draw(CardOne, NewGameDeck, NewGameDeck1),
                                        draw(CardTwo, NewGameDeck1, NewGameDeck2),
                                        draw(CardThree, NewGameDeck2, NewGameDeck3),
                                        draw(CardFour, NewGameDeck3, NewGameDeck4),
                                        HNewGameDeck = NewGameDeck4,
                                        HumanHandBeforeMove = [CardOne, CardTwo, CardThree, CardFour].

/**
Function Name: dealComputerCards
Purpose: Deals 4 cards to the Computer player
Parameters:
    State, List containing all variables relevant to game play.
    HNewGameDeck, List containing all cards in the deck after Human Cards are dealt.
    NewComputerHand, Variable that will be instantiated to list of cards dealt to Computer hand.
    CNewGameDeck, Variable that will be instantiated to new deck after cards are dealt to computer.
**/
dealComputerCards(HNewGameDeck, ComputerHandBeforeMove, CNewGameDeck) :- draw(CardOne, HNewGameDeck, NewGameDeck1),
                                        draw(CardTwo, NewGameDeck1, NewGameDeck2),
                                        draw(CardThree, NewGameDeck2, NewGameDeck3),
                                        draw(CardFour, NewGameDeck3, NewGameDeck4),
                                        CNewGameDeck = NewGameDeck4,
                                        ComputerHandBeforeMove = [CardOne, CardTwo, CardThree, CardFour].

/**
Function Name: dealTableCards
Purpose: Deals 4 cards to the Table
Parameters:
    State, List containing all variables relevant to game play.
    CNewGameDeck, List containing all cards in the deck after Computer Cards are dealt.
    NewComputerHand, Variable that will be instantiated to list of cards dealt to Computer hand.
    TNewGameDeck, Variable that will be instantiated to new deck after cards are dealt to table.
**/
dealTableCards(CNewGameDeck, TableCardsBeforeMove, TNewGameDeck) :- draw(CardOne, CNewGameDeck, NewGameDeck1),
                                        draw(CardTwo, NewGameDeck1, NewGameDeck2),
                                        draw(CardThree, NewGameDeck2, NewGameDeck3),
                                        draw(CardFour, NewGameDeck3, NewGameDeck4),
                                        TNewGameDeck = NewGameDeck4,
                                        TableCardsBeforeMove = [CardOne, CardTwo, CardThree, CardFour].

/**
Function Name: playRound
Purpose: Begin playing current round
Parameters: State, List containing all variables relevant to game play.
**/
playRound(State) :- shuffleDeck(NewGameDeck, GameDeckBeforeMove),
                    dealHumanCards(GameDeckBeforeMove, HumanHandBeforeMove, HNewGameDeck),
                    dealComputerCards(HNewGameDeck, ComputerHandBeforeMove, CNewGameDeck),
                    dealTableCards(CNewGameDeck, TableCardsBeforeMove, TNewGameDeck),
                    /** Piles not being properly accessed from state. **/
                    getHumanPileFromState(State, HumanPile),
                    getComputerPileFromState(State, ComputerPile),
                    printBoard(State, HumanPile, HumanHandBeforeMove, TableCardsBeforeMove, ComputerPile, ComputerHandBeforeMove),
                    getRoundNumFromState(State, RoundNum),
                    getHumanScoreFromState(State, HumanScore),
                    getComputerScoreFromState(State, ComputerScore),
                    getBuildsFromState(State, Builds),
                    GameDeck = TNewGameDeck,
                    write("About to get move."),
                    NewState = [RoundNum, GameDeck, HumanScore, HumanHand, HumanPile, ComputerScore, ComputerHand, ComputerPile, Builds, TableCards, NextPlayer].

/**
Function Name: startNewTournament
Purpose: Begins a new tournament and initializes game state.
Algorithm: Create game state list and initialize necessary variables.
**/
startNewTournament() :- RoundNum = 0,
                        HumanScore = 0,
                        ComputerScore = 0,
                        NextPlayer = human,
                        HumanPile = [],
                        ComputerPile = [],
                        Builds = [],
                        State = [RoundNum, GameDeck, HumanScore, HumanHand, HumanPile, ComputerScore, ComputerHand, ComputerPile, Builds, TableCards, NextPlayer],
                        playRound(State).
startNewTournament() :- write("Failed to start new tournament.").

/**
Function Name: loadGame
Purpose: Load a saved game state
**/
loadGame() :- write("Placeholder.").

/**
Function Name: loadOrNew
Purpose: Parse user input and load saved game, start new tournament, or re-prompt user if they enter invalid input.
**/
loadOrNew(Input) :- Input == y,
    loadGame().

loadOrNew(Input) :- Input == n,
    startNewTournament().

loadOrNew(_) :- write("Invalid input."), nl,
                start().

/**
Function Name: start
Purpose: Starts the game flow. Allows user to input 
**/
start() :- write("Would you like to load a saved game?(y/n): "),
            read(Input),
            loadOrNew(Input).

