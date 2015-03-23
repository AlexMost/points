"use strict"

Immutable = require 'immutable'
{POINT_STATE, PLAYER, GAME_CYCLE} = require './game_state'


initPointsMap = (width, height) ->
    rawMap = {}
    for i in [0...width]
        rawMap[i] = {}
        for j in [0...  height]
            rawMap[i][j] = POINT_STATE.NOT_SET
    Immutable.fromJS rawMap


addPoint = (x, y, player, gameState) ->
    newPlayer = if gameState.get("player") is PLAYER.FIRST
        PLAYER.SECOND
    else
        PLAYER.FIRST

    gameState
    .updateIn(["pointsMap", "#{x}", "#{y}"], -> player)
    .set("player", newPlayer)


isValidPointRange = (x, y, gameState) ->
    width = gameState.get("width")
    height = gameState.get("height")
    x <= width and y <= height and x >= 0 and y >= 0


isValidPlayer = (player, gameState) ->
    currentPlayer = gameState.get("player")
    player is currentPlayer


isValidGameCycleForAddPoint = (gameState) ->
    GAME_CYCLE.ON_AIR == gameState.get("gameCycle")


isFreePoint = (x, y, gameState) ->
    point = gameState.getIn(["pointsMap", "#{x}", "#{y}"])
    point == POINT_STATE.NOT_SET


module.exports = {
    initPointsMap,
    addPoint,
    isValidPointRange,
    isValidPlayer,
    isValidGameCycleForAddPoint,
    isFreePoint
}