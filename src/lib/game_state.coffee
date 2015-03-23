"use strict"

Immutable = require 'immutable'


Record = Immutable.Record
Map = Immutable.Map


[START_GAME, ON_AIR, END_GAME] = [0..2]
GAME_CYCLE = {START_GAME, ON_AIR, END_GAME}


[FIRST, SECOND] = [1, 2]
PLAYER = {FIRST, SECOND}


POINT_STATE = {NOT_SET: 0, FIRST, SECOND}


GameState = Record(
    pointsMap: Map({})
    width: 0
    height: 0
    gameCycle: GAME_CYCLE.START_GAME
    player: PLAYER.FIRST
)


module.exports = {
    GAME_CYCLE
    PLAYER
    GameState
    POINT_STATE
}