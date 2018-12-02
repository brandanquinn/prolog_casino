/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************
* General Utility Clauses  *                  
***************************/

/**
Clause Name: getLengthOfList
Purpose: Gets the length of a given list.
Parameters:
        List, list to get length of.
        Tail, Value incrementing as we move through list to final position.
        Length, Length of list after fully iterating. (Value of tail.)
**/
getLengthOfList(List, Length) :- getLengthOfList(List, 0, Length).

getLengthOfList([], Length, Length).

getLengthOfList([_ | Rest], Tail, Length) :-
  NewTail is Tail + 1 ,
  getLengthOfList(Rest, NewTail, Length).


/**
Clause Name: subset
Purpose: Find subsets of given list.
Parameters:
        ListInput, List provided by user (in this case will be cards on table)
        ListOutput, Uninstantiated variable to pass subsets back through the clause.
**/
subset([], []).

subset([Element | Rest], [Element | Rest2]):-
  subset(Rest, Rest2).

subset([_ | Rest ], Rest2):-
  subset(Rest, Rest2).

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


