"use strict"
l = require 'lodash'
{getPointIdx} = require './point'


getCycles = (point, pointsMap) ->
    discovered = {}
    stack = []

    stack.push point

    [y, x] = point
    n = pointsMap[y][x]

    while stack.length
        current_point = stack.pop()
        [current_y, current_x] = current_point

        if current_point not of discovered
            discovered[current_point] = true
            neighbors = findNeighborsWithN(n,
                [current_y, current_x], pointsMap)
            for neighbor in neighbors
                stack.push neighbor


###
DFS search implementation
###
getConnectedPoints = (point, pointsMap) ->
    connectedPoints = []
    stack = []
    visitedMap = {}

    stack.push point
    visitedMap[point] = true

    [y, x] = point
    n = pointsMap[y][x]

    while stack.length
        [current_y, current_x] = stack.pop()
        connectedPoints.push [current_y, current_x]
        neighbors = findNeighborsWithN(n, [current_y, current_x], pointsMap)
        for neighbor in neighbors when neighbor not of visitedMap
            stack.push neighbor
            visitedMap[neighbor] = true

    connectedPoints


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
            connectedPointsGraph[point_idx][neighborIdx] = null

    connectedPointsGraph


findNeighborsWithN = (n, [y, x], pointsMap) ->
    [[y-1, x-1], [y, x-1], [y+1, x-1], [y-1, x],
     [y+1, x], [y-1, x+1], [y, x+1], [y+1, x+1]]
    .filter(([y, x]) -> pointsMap[y]?[x] is n)


module.exports = {
    getCycles, getConnectedPoints, findNeighborsWithN,
    getConnectedPointsGraph}
