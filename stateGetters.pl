/***************************
* Name: Brandan Quinn      *
* Project: Prolog Casino   *
* Class: OPL Section 1     *
* Date:                    *
***************************
* State List Getters       *                  
***************************/


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
Clause Name: getComputerScoreFromState
Purpose: Pulls the ComputerScore from the State List
Parameters:
    State, List containing all variables relevant to game play.
    ComputerScore, Variable to be instantiated to ComputerScore from State.
**/
getComputerScoreFromState(State, _) :- State = [].
getComputerScoreFromState(State, ComputerScore) :- nth0(1, State, ComputerScore).

/**
Clause Name: getComputerHandFromState
Purpose: Pulls the ComputerHand from the State List
Parameters:
    State, List containing all variables relevant to game play.
    ComputerHand, Variable to be instantiated to ComputerHand from State.
**/
getComputerHandFromState(State, _) :- State = [].
getComputerHandFromState(State, ComputerHand) :- nth0(2, State, ComputerHand).

/**
Clause Name: getComputerPileFromState
Purpose: Pulls the ComputerPile from the State List
Parameters:
    State, List containing all variables relevant to game play.
    ComputerPile, Variable to be instantiated to ComputerPile from State.
**/
getComputerPileFromState(State, _) :- State = [].
getComputerPileFromState(State, ComputerPile) :- nth0(3, State, ComputerPile).

/**
Clause Name: getHumanScoreFromState
Purpose: Pulls the human score from the State List
Parameters:
    State, List containing all variables relevant to game play.
    HumanScore, Variable to be instantiated to HumanScore from State.
**/
getHumanScoreFromState(State, _) :- State = [].                   
getHumanScoreFromState(State, HumanScore) :- nth0(4, State, HumanScore).

/**
Clause Name: getHumanHandFromState
Purpose: Pulls the HumanHand from the State List
Parameters:
    State, List containing all variables relevant to game play.
    HumanHand, Variable to be instantiated to HumanHand from State.
**/
getHumanHandFromState(State, _) :- State = [].
getHumanHandFromState(State, HumanHand) :- nth0(5, State, HumanHand).

/**
Clause Name: getHumanPileFromState
Purpose: Pulls the HumanPile from the State List
Parameters:
    State, List containing all variables relevant to game play.
    HumanPile, Variable to be instantiated to HumanPile from State.
**/
getHumanPileFromState(State, _) :- State = [].
getHumanPileFromState(State, HumanPile) :- nth0(6, State, HumanPile).

/**
Clause Name: getTableCardsFromState
Purpose: Pulls the TableCards from the State List
Parameters:
    State, List containing all variables relevant to game play.
    TableCards, Variable to be instantiated to TableCards from State.
**/
getTableCardsFromState(State, _) :- State = [].
getTableCardsFromState(State, TableCards) :- nth0(7, State, TableCards).

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
Clause Name: getLastCapturerFromState
Purpose: Pulls the LastCapturer var from the State List
Parameters:
        State, List containing all variables relevant to game play.
        LastCapturer, Variable to be instantiated to LastCapturer from state.
**/
getLastCapturerFromState(State, _) :- State = [].
getLastCapturerFromState(State, LastCapturer) :- nth0(10, State, LastCapturer).

/**
Clause Name: getDeckFromState
Purpose: Pulls the GameDeck from the State List
Parameters:
    State, List containing all variables relevant to game play.
    NewGameDeck, Variable to be instantiated to GameDeck from State.
**/
getDeckFromState(State, _) :- State = [].
getDeckFromState(State, NewGameDeck) :- nth0(11, State, NewGameDeck).


/**
Clause Name: getPlayNextFromState
Purpose: Pulls the NextPlayer from the State List
Parameters:
    State, List containing all variables relevant to game play.
    NewNextPlayer, Variable to be instantiated to NextPlayer from State.
**/
getPlayNextFromState(State, _) :- State = [].
getPlayNextFromState(State, NewNextPlayer) :- nth0(12, State, NewNextPlayer).