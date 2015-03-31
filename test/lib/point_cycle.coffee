"use strict"

l = require 'lodash'
{
makeGraph, getCycles, findNeighborsWithN,
getConnectedPointsGraph, removeNeighborsCycles
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


exports.test_get_cycle = (test) ->
    test.expect(7)

    graph = [
        [1, 2], [1, 3], [1, 4], [2, 3],
        [3, 4], [2, 6], [4, 6], [8, 7],
        [8, 9], [9, 7]]

    cycles = getCycles(graph)

    expected_cycles = [
        [3, 2, 1]
        [4, 3, 2, 1]
        [4, 6, 2, 1]
        [3, 4, 6, 2, 1]
        [4, 3, 1]
        [6, 4, 3, 2]
        [9, 7, 8]
    ]

    cyclesHashMap = {}
    for cycle in cycles
        cyclesHashMap[cycle.toString()] = null

    for expected_cycle in expected_cycles
        test.ok(
            expected_cycle.toString() of cyclesHashMap,
            "must resolve path #{expected_cycle}")

    test.done()


exports.test_remove_neighbor_cycles = (test) ->
    graph =
        6: {4: null}
        4: {5: null, 6: null}
        5: {4: null}

    expected_result =
        6: {}
        4: {6: null, 5: null}
        5: {}

    actual_result = removeNeighborsCycles graph
    
    test.deepEqual(
        actual_result,
        expected_result,
        "must remove neighbors cycles")
    test.done()
