"use strict"

{createGame} = require '../../src/engine/game'
{addPointAction} = require '../../src/engine/actions/add_point'
{addPoint} = require '../../src/engine/lib/point'
{POINT_STATE, PLAYER, GAME_CYCLE} = require '../../src/engine/lib/game_state'
{assertRxActions} = require '../../src/rx_test_util'


exports.test_must_add_point = (test) ->
    gameInstance = createGame {width: 5, height: 5}
    gameState = gameInstance.getGameState().set(
        "gameCycle", GAME_CYCLE.ON_AIR)

    addedGameState = addPoint 1, 1, POINT_STATE.FIRST, gameState

    assertRxActions(
        addPointAction
        [[210, {
            action: "addPoint"
            x:1
            y:1
            player: PLAYER.FIRST
            point: POINT_STATE.FIRST
            gameState}]]
        [[210, {action: "addPoint", gameState: addedGameState}]]
        (isTrue) ->
            test.ok isTrue, "must add point"
            test.done()
    )
