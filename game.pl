/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************
* Base Gameplay            *                  
***************************/


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
        write('Invalid input.'), nl,
        start().

/**
Clause Name: loadGame
Purpose: Load a saved game state
**/
loadGame() :- 
        getSaveFileName(SaveFileName),
        catch(open(SaveFileName, read, TESTFILE), _, (write('Could not find file. Try again.'), nl, loadGame())),
        close(TESTFILE),
        open(SaveFileName, read, SAVEFILE),
        read(SAVEFILE, SavedState),
        close(SAVEFILE),
        assessRound(SavedState).

/**
Clause Name: startNewTournament
Purpose: Begins a new tournament and creates new round.
Algorithm: Create game state list and initialize necessary variables.
**/
startNewTournament() :- setupRound().
startNewTournament() :- write('Failed to start new tournament.').

/**
Clause Name: setupRound
Purpose: Initializes new round.
Algorithm: Shuffle deck, deal cards and create initial game state list.
**/
setupRound() :- 
        write('Call the coin toss to go first! (h/t): '),
        read(CoinTossInput),
        coinToss(CoinTossInput, NextPlayer),
        shuffleDeck(_, GameDeckBeforeMove),
        dealCards(GameDeckBeforeMove, HNewGameDeck, HumanHandBeforeMove),
        dealCards(HNewGameDeck, CNewGameDeck, ComputerHandBeforeMove),
        dealCards(CNewGameDeck, TNewGameDeck, TableCardsBeforeMove),
        RoundNum = 1,
        HumanScore = 0,
        ComputerScore = 0,
        HumanPile = [],
        ComputerPile = [],
        Builds = [],
        BuildOwners = [],
        LastCapturer = none,
        State = [RoundNum, ComputerScore, ComputerHandBeforeMove, ComputerPile, HumanScore, HumanHandBeforeMove, HumanPile, TableCardsBeforeMove, Builds, BuildOwners, LastCapturer, TNewGameDeck, NextPlayer],
        printBoard(State, HumanPile, HumanHandBeforeMove, TableCardsBeforeMove, ComputerPile, ComputerHandBeforeMove),               
        playRound(State).


assessRound(State) :-
        getDeckFromState(State, GameDeck),
        getHumanHandFromState(State, HumanHand),
        getComputerHandFromState(State, ComputerHand),
        isRoundOver(State, GameDeck, HumanHand, ComputerHand).

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
        getLastCapturerFromState(State, LastCapturer),
        checkHandsEmpty(HumanHandBeforeMove, HumanHandAfterCheck, ComputerHandBeforeMove, ComputerHandAfterCheck, NewGameDeck, GameDeck),
        % [RoundNum, ComputerScore, ComputerHand, ComputerPile, HumanScore, HumanHand, HumanPile, TableCards, Builds, BuildOwners, LastCapturer, GameDeck, NextPlayer]
        NewState = [RoundNum, ComputerScore, ComputerHandAfterCheck, ComputerPileBeforeMove, HumanScore, HumanHandAfterCheck, HumanPileBeforeMove, TableCardsBeforeMove, BuildsBeforeMove, BuildOwners, LastCapturer, GameDeck, NextPlayer],
        printBoard(NewState, HumanPileBeforeMove, HumanHandAfterCheck, TableCardsBeforeMove, ComputerPileBeforeMove, ComputerHandAfterCheck),
        getMove(NewState, BuildsBeforeMove, TableCardsBeforeMove, HumanHandAfterCheck).  
