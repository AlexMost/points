"use strict"

{createGame} = require '../src/engine/game'
{isFreePoint} = require '../src/engine/lib/point'
{POINT_STATE, GAME_CYCLE, PLAYER} = require '../src/engine/lib/game_state'


exports.test_should_create_game = (test) ->
    newGameInstance = createGame {width: 30, height: 30}
    gameState = newGameInstance.getGameState()

    test.ok(gameState, "must init gameState")

    test.equal(
        gameState.get("gameCycle"),
        GAME_CYCLE.START_GAME,
        "must be on start game cycle")

    test.equal(
        gameState.get("width"), 30,
        "Must set width from init options")

    test.equal(
        gameState.get("height"), 30,
        "Must set height from init options")

    test.ok(
        newGameInstance.getGameState() == gameState,
        "getGameState must return the same gameState")

    test.done()


exports.test_should_init_game_field = (test) ->
    newGameInstance = createGame {width: 30, height: 30}
    gameState = newGameInstance.getGameState()
    pointsMap = gameState.get("pointsMap")

    test.equal(pointsMap.size, 30,
        "must init points map with correct size")
    
    test.equal(
        pointsMap.getIn(["0", "0"]),
        POINT_STATE.NOT_SET,
        "must be not set as initial state of point")
    
    test.done()


exports.test_should_connect_player = (test) ->
    newGameInstance = createGame {width: 2, height: 2}
    gameState = newGameInstance.getGameState()
    updStream = newGameInstance.getUpdateStream()

    updStream
    .filter(({action}) -> action is "connectPlayer")
    .subscribe(
        ({gameState}) ->
            test.ok(
                gameState.get("playerFirstOn"),
                "player first must be connected")
            test.done()
        (err) -> throw new Error(err.message)
    )

    newGameInstance.connectPlayer(PLAYER.FIRST)


exports.should_start_game = (test) ->
    newGameInstance = createGame {width: 2, height: 2}
    gameState = newGameInstance.getGameState()
    updStream = newGameInstance.getUpdateStream()

    updStream
    .filter(({action}) -> action is "startGame")
    .subscribe(
        ({gameState}) ->
            test.equal(
                gameState.get("gameCycle"),
                GAME_CYCLE.ON_AIR,
                "game cycle must be on air")
            test.done()
        (err) -> throw new Error(err.message)
    )

    newGameInstance.startGame()


exports.test_should_add_point = (test) ->
    newGameInstance = createGame {
        width: 2, height: 2, gameCycle: GAME_CYCLE.ON_AIR}
    updStream = newGameInstance.getUpdateStream()

    updStream
    .filter(({action}) -> action is "addPoint")
    .subscribe(
        ({gameState}) ->
            test.ok(
                !isFreePoint(1, 1, gameState),
                "point must not be free")
            test.done()
        (err) -> throw new Error(err.message)
    )

    newGameInstance.addPoint(1, 1, PLAYER.FIRST)
