"use strict"

l = require 'lodash'
{makeGraph, getCycle, getConnectedPoints,
findNeighborsWithN} = require '../../src/lib/point_cycle'


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
        [0, 0, 0]
        [0, 1, 1]
        [1, 0, 0]
    ]

    expectedResult = [[2, 0], [1, 1], [1, 2]]
    actualResult = getConnectedPoints([2, 0], points)

    test.equal(l.size(actualResult), 3, "must resolve 3 connected points")
    test.deepEqual(
        expectedResult, actualResult, "must resolve connected points")
    test.done()


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

