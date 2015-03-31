"use strict"
l = require 'lodash'
{getPointIdx} = require './point'


getCycles = (graph) ->
    cycles = []
    addedCycles = {}

    visited = (node, path) -> node in path

    findNewCycle = (path) ->
        start_node = path[0]
        next_node = null
        sub = []

        for edge in graph
            [node1, node2] = edge

            if start_node in edge
                if node1 is start_node
                    next_node = node2
                else
                    next_node = node1

            if not visited(next_node, path)
                # neighbor node not on path yet
                sub = [next_node]
                sub = sub.concat(path)
                # explore extended path
                findNewCycle(sub)
            else if l.size(path) > 2 and next_node is path[path.length - 1]
                # cycle found
                pathCopy = path[..]
                pathHash = pathCopy.sort().toString()
                if pathHash not of addedCycles
                    cycles.push path
                    addedCycles[pathHash] = null

    for edge in graph
        for node in edge
            findNewCycle([node])

    cycles


getConnectedPointsGraph = (y, x, points) ->
    connectedPointsGraph = {}
    stack = []
    visitedMap = {}
    rows_count = l.size points
    point = [y, x]

    stack.push point
    visitedMap[point] = true
    n = points[y][x]

    while stack.length
        [current_y, current_x] = stack.pop()

        point_idx = getPointIdx current_y, current_x, rows_count
        connectedPointsGraph[point_idx] = {}

        neighbors = findNeighborsWithN(n, [current_y, current_x], points)

        for neighbor in neighbors
            if neighbor not of visitedMap
                stack.push neighbor
                visitedMap[neighbor] = true
            neighborIdx = getPointIdx neighbor[0], neighbor[1], rows_count
            if neighborIdx != point_idx
                connectedPointsGraph[point_idx][neighborIdx] = null

    connectedPointsGraph


findNeighborsWithN = (n, [y, x], pointsMap) ->
    [[y-1, x-1], [y, x-1], [y+1, x-1], [y-1, x],
     [y+1, x], [y-1, x+1], [y, x+1], [y+1, x+1]]
    .filter(([y, x]) -> pointsMap[y]?[x] is n)


removeNeighborsCycles = (graph) ->
    result_graph = {}
    for point, neighbors of graph

        unless point of result_graph
            result_graph[point] = {}

        for neighbor of neighbors
            if point not of (result_graph[neighbor] or {})
                result_graph[point][neighbor] = null
            else if not neighbor of result_graph
                result_graph[neighbor] = {}

    result_graph


module.exports = {
    getCycles, findNeighborsWithN,
    getConnectedPointsGraph, removeNeighborsCycles}
