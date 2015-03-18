Immutable = require 'immutable'


Record = Immutable.Record
Map = Immutable.Map


[START_GAME, ON_AIR, END_GAME] = [0..2]
GAME_CYCLE = {START_GAME, ON_AIR, END_GAME}


[FIRST, SECOND] = [0..1]
USER_TURN = {FIRST, SECOND}


[NOT_SET, POINT_USER1, POINT_USER2] = [0..2]
POINT_STATE = {NOT_SET, POINT_USER1, POINT_USER2}


GameState = Record(
    pointsMap: Map({})
    width: 0
    height: 0
    gameCycle: GAME_CYCLE.START_GAME
    userTurn: USER_TURN.FIRST
)


module.exports = {
    GAME_CYCLE
    USER_TURN
    GameState
    POINT_STATE
}