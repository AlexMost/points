{initPointsMap} = require '../../src/lib/point'
{POINT_STATE, GAME_CYCLE} = require '../../src/lib/game_state'


exports.test_init_points_map = (test) ->
    pointsMap = initPointsMap 20, 20
    test.equal(pointsMap.size, 20, "must have 20 columns")
    column1 = pointsMap.get("0")
    test.equal(column1.size, 20, "must have 20 rows")
    test.equal(column1.get("0"), POINT_STATE.NOT_SET,
        "must be not set by default")
    test.done()