{initPointsMap, addPoint} = require '../../src/lib/point'
{createGame} = require '../../src/game'
{POINT_STATE, GAME_CYCLE, POINT_STATE} = require '../../src/lib/game_state'


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
    newGameState = addPoint(1, 1, POINT_STATE.POINT_USER1, gameState)

    test.equal(
        newGameState.getIn(["pointsMap", "1", "1"]),
        POINT_STATE.POINT_USER1,
        "Must return new state with checked point")
    
    test.done()