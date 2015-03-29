"use strict"

l = require 'lodash'
{makeGraph, getCycles, getConnectedPoints,
findNeighborsWithN, getConnectedPointsGraph
} = require '../../src/lib/point_cycle'


exports.test_find_neighbors_with_n = (test) ->
    points = [
        [0, 0, 0]
        [1, 1, 0]
        [0, 1, 0]
    ]

    expected = [[1, 0], [2, 1]]
    actual = findNeighborsWithN(1, [1, 1], points)
    test.deepEqual(actual, expected, "must find neighbors")
    
    expected2 = [[1, 1], [2, 1]]
    actual2 = findNeighborsWithN(1, [1, 0], points)
    test.deepEqual(actual2, expected2, "must find neighbors")

    expected3 = [[1, 2]]
    actual3 = findNeighborsWithN(0, [2, 2], points)
    test.deepEqual(actual3, expected3, "must find neighbors")
    test.done()


exports.test_get_connected_points = (test) ->
    points = [
        [0, 0, 0]  # 0, 1, 2
        [0, 1, 1]  # 3, 4, 5
        [1, 0, 0]  # 6, 7, 8
    ]

    expectedResult = [[2, 0], [1, 1], [1, 2]]

    actualResult = getConnectedPoints([2, 0], points)

    test.equal(l.size(actualResult), 3, "must resolve 3 connected points")
    test.deepEqual(
        expectedResult, actualResult, "must resolve connected points")
    test.done()


exports.get_connected_points_graph = (test) ->
    points = [
        [0, 0, 0]  # 0, 1, 2
        [0, 1, 1]  # 3, 4, 5
        [1, 0, 0]  # 6, 7, 8
    ]

    actual_result = getConnectedPointsGraph 2, 0, points
    expected_result =
        6: {4: null}
        4: {5: null, 6: null}
        5: {4: null}

    test.deepEqual(
        actual_result,
        expected_result,
        "connected points graph test")

    test.done()


# exports.test_get_cycle = (test) ->
#     points = [
#         [0, 0, 0, 0, 1]
#         [0, 1, 1, 1, 0]
#         [1, 0, 0, 1, 0]
#         [1, 0, 1, 0, 1]
#         [0, 1, 0, 0, 0]
#     ]

#     cycles = getCycles([2, 0], points)
#     # console.log cycles
#     test.done()

