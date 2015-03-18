{createGame} = require '../../src/lib/game'
{POINT_STATE} = require '../../src/lib/game_state'

exports.test_should_create_game = (test) ->
    newGameInstance = createGame {}
    updateStream = newGameInstance.getUpdateStream()

    updateStream.filter(({action}) -> action is "start")
    .subscribe(
        ({gameState}) ->
            test.ok(gameState, "must init gameState")
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


