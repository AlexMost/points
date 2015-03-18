{createGame} = require '../src/game'
{POINT_STATE, GAME_CYCLE} = require '../src/lib/game_state'

exports.test_should_create_game = (test) ->
    newGameInstance = createGame {width: 30, height: 30}
    updateStream = newGameInstance.getUpdateStream()

    updateStream.filter(({action}) -> action is "start")
    .subscribe(
        ({gameState}) ->
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
            test.done()
        -> test.ok(false, "must not fail")
    )



exports.test_should_init_game_field = (test) ->
    newGameInstance = createGame {width: 30, height: 30}

    updateStream = newGameInstance.getUpdateStream()

    updateStream.filter(({action}) -> action is "start")
    .subscribe(
        ({gameState}) ->
            pointsMap = gameState.get("pointsMap")
            test.equal(pointsMap.size, 30,
                "must init points map with correct size")
            
            test.equal(
                pointsMap.getIn(["0", "0"]),
                POINT_STATE.NOT_SET,
                "must be not set as initial state of point")
            test.done()
        -> test.ok(false, "must not fail")
    )


