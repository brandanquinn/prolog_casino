/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************
* Game View Logic          *                  
***************************/

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
printCards([Top | Rest]) :- 
        Top = (Suit, Type),
        write(Suit),
        write(Type),
        write(' '),
        printCards(Rest).

/**
Clause Name: printBoard
Purpose: Prints the current board using lists from State
Parameters:
    NewHumanHand, List containing cards in human's hand..
    NewTableCards, List containing cards on the table.
    NewComputerHand, List containing cards in computer's hand.
**/
printBoard(State, HumanPile, HumanHand, TableCards, ComputerPile, ComputerHand) :- 
        write('--------------------------------'), nl,
        getPlayNextFromState(State, NewNextPlayer),
        getBuildsFromState(State, Builds),
        getBuildOwnersFromState(State, BuildOwners),
        printWhoseTurn(NewNextPlayer),
        getHumanScoreFromState(State, HumanScore),
        getComputerScoreFromState(State, ComputerScore),
        getRoundNumFromState(State, RoundNum),
        write('Round Number: '),
        write(RoundNum), nl,
        write('Human Score: '),
        write(HumanScore), nl,
        write('Human Pile: '),
        printCards(HumanPile),
        nl,
        write('Human Cards: '),
        printCards(HumanHand),
        nl,
        write('Table Cards: '),
        printBuilds(Builds),
        printCards(TableCards),
        nl,
        write('Computer Cards: '),
        printCards(ComputerHand),
        nl,
        write('Computer Pile: '),
        printCards(ComputerPile),
        nl,
        write('Computer Score: '),
        write(ComputerScore), nl,
        write('Build Owners: '),
        printBuildOwners(Builds, BuildOwners), nl,
        write('--------------------------------'),
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
        write('[ ').

/**
Clause Name: printClosedBracketIfMB
Purpose: Prints an extra closed bracket if build being printed is a multi-build.
Parameters: Build, Build being printed.
**/
printClosedBracketIfMB(Build) :-
        length(Build, 1).
printClosedBracketIfMB(_) :-
        write('] ').

/**
Clause Name: printBuild
Purpose: Prints the contents of a build set.
Parameters: Build, Build being printed.
**/
printBuild([]).

printBuild(Build) :-
        [Set | Rest] = Build,
        write('[ '), printCards(Set), write('] '),
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
        write(Owner1), write(' '),
        printBuildOwners(RestOfBuilds, RestOfOwners).

/**
Clause Name: printWhoseTurn
Purpose: Prints whose turn it is.
Parameters: NewNextPlayer, Variable containing whose turn it is.
**/
printWhoseTurn(NewNextPlayer) :- 
        NewNextPlayer = human,
        write('Human players turn.'), nl.
printWhoseTurn(NewNextPlayer) :- 
        NewNextPlayer = computer,
        write('Computer players turn.'), nl.
printWhoseTurn(_) :- write('Unknown Turn'), nl. 