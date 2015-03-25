"use strict"

{makeGraph, getCycle, getConnectedPoints, findNeighborsWithN
} = require '../../src/lib/point_cycle'


exports.test_find_neighbors_with_n = (test) ->
    points = [
        [0, 0, 0]
        [1, 1, 0]
        [0, 1, 0]
    ]

    expected = [[0, 1], [1, 2]]
    actual = findNeighborsWithN(1, [1, 1], points)
    test.deepEqual(actual, expected, "must find neighbors")
    
    expected2 = [[1, 1], [1, 2]]
    actual2 = findNeighborsWithN(1, [0, 1], points)
    test.deepEqual(actual2, expected2, "must find neighbors")

    test.done()


# exports.test_get_connected_points = (test) ->
#     points = [
#         [0, 0, 0]
#         [0, 1, 1]
#         [1, 0, 0]
#     ]

#     expectedResult = [[0, 2], [1, 1], [2, 1]]
#     actualResult = getConnectedPoints(makeGraph(points))
#     test.deepEqual(
#         actualResult,
#         expectedResult,
#         "must resolve connected points"
#     )
#     test.done()


# exports.test_get_cycle = (test) ->
#     points = [
#         [0, 0, 0, 0, 0]
#         [0, 1, 1, 1, 0]
#         [1, 0, 0, 1, 0]
#         [1, 0, 1, 0, 1]
#         [0, 1, 0, 0, 0]
#     ]

#     cycle = getCycle makeGraph(points)

#     expectedResult = [
#                [1, 1], [2, 1], [3, 1],
#         [0, 2],                [3, 2],
#         [0, 3],        [2, 3]
#                [1, 4]
#     ]

#     test.deepEqual(cycle, expectedResult, "Must resolve cycle")
#     test.done()

