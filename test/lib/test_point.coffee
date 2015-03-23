"use strict"

{initPointsMap, addPoint, isValidPointRange, isValidPlayer
isFreePoint} = require '../../src/lib/point'
{createGame} = require '../../src/game'
{POINT_STATE, GAME_CYCLE, POINT_STATE,
PLAYER} = require '../../src/lib/game_state'


exports.test_init_points_map = (test) ->
    pointsMap = initPointsMap 20, 20
    test.equal(pointsMap.size, 20, "must have 20 columns")
    column1 = pointsMap.get("0")
    test.equal(column1.size, 20, "must have 20 rows")
    test.equal(column1.get("0"), POINT_STATE.NOT_SET,
        "must be not set by default")
    test.done()


exports.test_add_point = (test) ->
    newGameInstance = createGame {width: 30, height: 30}
    gameState = newGameInstance.getGameState()
    newGameState = addPoint(1, 1, POINT_STATE.FIRST, gameState)

    test.equal(
        newGameState.getIn(["pointsMap", "1", "1"]),
        POINT_STATE.FIRST,
        "Must return new state with checked point")

    test.equal(
        newGameState.get("player"), PLAYER.SECOND,
        "Must change player after point add")
    
    test.done()


exports.test_is_valid_point_range = (test) ->
    newGameInstance = createGame {width: 2, height: 2}
    gameState = newGameInstance.getGameState()
    test.ok(
        isValidPointRange(1, 1, gameState),
        "must be valid point range")

    test.ok(
        !isValidPointRange(3, 3, gameState),
        "must be invalid point range (out of bounds)")
    test.ok(
        !isValidPointRange(-1, -1, gameState),
        "must be invalid point range (below zero coordinates)")

    test.done()


exports.test_is_valid_player = (test) ->
    newGameInstance = createGame {width: 2, height: 2}
    gameState = newGameInstance.getGameState()
    test.ok(
        isValidPlayer(PLAYER.FIRST, gameState),
        "must be current player")
    test.done()


exports.test_is_free_point = (test) ->
    newGameInstance = createGame {width: 2, height: 2}
    gameState = newGameInstance.getGameState()
    test.ok(isFreePoint(1, 1, gameState), "must be free point")
    newGameState = addPoint(1, 1, POINT_STATE.FIRST, gameState)
    test.ok(!isFreePoint(1, 1, newGameState), "must be not free point")
    test.done()
