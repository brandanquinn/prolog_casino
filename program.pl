/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************
* Game Client File         *                  
***************************/

:-style_check(-singleton).

:- [game].
:- [generalUtility].
:- [gameUtility].
:- [view].
:- [move].
:- [ai].
:- [stateGetters].

/**
Clause Name: start
Purpose: Starts the game flow. Allows user to input 
**/
start() :- 
        write('Would you like to load a saved game?(y/n): '),
        read(Input),
        loadOrNew(Input).