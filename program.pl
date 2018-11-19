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
Function Name: startGame
Purpose: Begins the game for user; needs to be expanded upon later.
Parameters:
Algorithm: Simply prints a message to the screen.
**/
startGame() :- write("Game is starting.").

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

% Game Players
player("Human").
player("Computer").

/**
Function Name: shuffledeck
Purpose: Shuffle a Deck List and assign it to a variable
Parameters: Variable to assign shuffled deck list to.
Algorithm: 
    1. Assign pre-built deck list to Deck variable
    2. Call random_permutation() to shuffle pre-built deck list and assign the new list to ShuffledDeck variable 
**/
shuffleDeck(GameDeck) :-    deck(NewDeck),
                            random_permutation(NewDeck, GameDeck).

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

/**
Function Name: draw
Purpose: Draw a Card from the top of the deck.
Parameters: Takes an uninstantiated Card variable and a Deck List
Algorithm: Pulls the top card from the Deck List and assigns it to the Card variable.
**/
draw(Card, GameDeck, NewGameDeck) :- GameDeck = [Card | Rest],
                                    NewGameDeck = Rest.

/**
Function Name: getDeckFromState
Purpose: Pulls the GameDeck from the State List
Parameters:
    State, List containing all variables relevant to game play.
    GameDeck, Variable to be instantiated to GameDeck from State.
**/
getDeckFromState(State, _) :- State = [].
getDeckFromState(State, GameDeck) :- [GameDeck | _] = State.

/**
Function Name: getHumanHandFromState
Purpose: Pulls the HumanHand from the State List
Parameters:
    State, List containing all variables relevant to game play.
    HumanHand, Variable to be instantiated to HumanHand from State.
**/
getHumanHandFromState(State, _) :- State = [].
getHumanHandFromState(State, HumanHand) :- [HumanHand | _] = State.

/**
Function Name: getComputerHandFromState
Purpose: Pulls the ComputerHand from the State List
Parameters:
    State, List containing all variables relevant to game play.
    ComputerHand, Variable to be instantiated to ComputerHand from State.
**/
getComputerHandFromState(State, _) :- State = [].
getComputerHandFromState(State, ComputerHand) :- [ComputerHand | _] = State.

/**
Function Name: dealHumanCards
Purpose: Deals 4 cards to the Human player
Parameters:
    State, List containing all variables relevant to game play.
    GameDeck, List containing all cards in the deck.
    NewHumanHand, Variable that will be instantiated to list of cards dealt to Human hand.
    HNewGameDeck, Variable that will be instantiated to new deck after cards are dealt to human.
**/
dealHumanCards(State, GameDeck, NewHumanHand, HNewGameDeck) :- draw(CardOne, GameDeck, NewGameDeck1),
                                        draw(CardTwo, NewGameDeck1, NewGameDeck2),
                                        draw(CardThree, NewGameDeck2, NewGameDeck3),
                                        draw(CardFour, NewGameDeck3, NewGameDeck4),
                                        HNewGameDeck = NewGameDeck4,
                                        NewHumanHand = [CardOne, CardTwo, CardThree, CardFour],
                                        write("Human Cards: "),
                                        printCards(NewHumanHand),
                                        nl.

/**
Function Name: dealComputerCards
Purpose: Deals 4 cards to the Computer player
Parameters:
    State, List containing all variables relevant to game play.
    HNewGameDeck, List containing all cards in the deck after Human Cards are dealt.
    NewComputerHand, Variable that will be instantiated to list of cards dealt to Computer hand.
    CNewGameDeck, Variable that will be instantiated to new deck after cards are dealt to computer.
**/
dealComputerCards(State, HNewGameDeck, NewComputerHand, CNewGameDeck) :- draw(CardOne, HNewGameDeck, NewGameDeck1),
                                        draw(CardTwo, NewGameDeck1, NewGameDeck2),
                                        draw(CardThree, NewGameDeck2, NewGameDeck3),
                                        draw(CardFour, NewGameDeck3, NewGameDeck4),
                                        CNewGameDeck = NewGameDeck4,
                                        NewComputerHand = [CardOne, CardTwo, CardThree, CardFour],
                                        write("Computer Cards: "),
                                        printCards(NewComputerHand),
                                        nl.

/**
Function Name: dealTableCards
Purpose: Deals 4 cards to the Table
Parameters:
    State, List containing all variables relevant to game play.
    CNewGameDeck, List containing all cards in the deck after Computer Cards are dealt.
    NewComputerHand, Variable that will be instantiated to list of cards dealt to Computer hand.
    TNewGameDeck, Variable that will be instantiated to new deck after cards are dealt to table.
**/
dealTableCards(State, CNewGameDeck, NewTableCards, TNewGameDeck) :- draw(CardOne, CNewGameDeck, NewGameDeck1),
                                        draw(CardTwo, NewGameDeck1, NewGameDeck2),
                                        draw(CardThree, NewGameDeck2, NewGameDeck3),
                                        draw(CardFour, NewGameDeck3, NewGameDeck4),
                                        TNewGameDeck = NewGameDeck4,
                                        NewTableCards = [CardOne, CardTwo, CardThree, CardFour],
                                        write("Table Cards: "),
                                        printCards(NewTableCards),
                                        nl.

/**
Function Name: playRound
Purpose: Begin playing current round
Parameters: State, List containing all variables relevant to game play.
**/
playRound(State) :- getDeckFromState(State, GameDeck),
                    shuffleDeck(GameDeck),
                    dealHumanCards(State, GameDeck, NewHumanHand, HNewGameDeck),
                    dealComputerCards(State, HNewGameDeck, NewComputerHand, CNewGameDeck),
                    dealTableCards(State, CNewGameDeck, NewTableCards, TNewGameDeck).

/**
Function Name: startNewTournament
Purpose: Begins a new tournament and initializes game state.
Algorithm: Create game state list and initialize necessary variables.
**/
startNewTournament() :- RoundNum = 0,
                        HumanScore = 0,
                        ComputerScore = 0,
                        State = [Score, RoundNum, GameDeck, Human, HumanScore, HumanHand, HumanPile, Computer, ComputerScore, ComputerHand, ComputerPile, Builds, TableCards, PlayNext],
                        playRound(State).

