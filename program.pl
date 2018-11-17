/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************/

% cards
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
shuffledeck(ShuffledDeck) :-    deck(Deck),
                                random_permutation(Deck, ShuffledDeck).

/**
Function Name: printdeck
Purpose: Print the entirety of a deck 
Parameters: Accepts a list
Algorithm:
    1. If list param is empty, do nothing.
    2. Else: 
        a. print the card on top of the deck
        b. recursively call printdeck with the rest of the deck.
**/
printdeck([]).
printdeck([Top | Rest]) :- write(card(Top)),
                            printdeck(Rest).

/**
Function Name: draw
Purpose: Draw a Card from the top of the deck.
Parameters: Takes an uninstantiated Card variable and a Deck List
Algorithm: Pulls the top card from the Deck List and assigns it to the Card variable.
**/
draw(Card, Deck) :- Deck = [Card | Rest].

:- initialization forall(shuffledeck(ShuffledDeck), printdeck(ShuffledDeck)).

