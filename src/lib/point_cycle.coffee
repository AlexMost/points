getCycle = (y, x, pointsMap) ->
    # connectedPoints = getConnectedPoints(x, y, pointsMap)


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


findNeighborsWithN = (n, [y, x], pointsMap) ->
    [[y-1, x-1], [y, x-1], [y+1, x-1], [y-1, x],
     [y+1, x], [y-1, x+1], [y, x+1], [y+1, x+1]]
    .filter(([y, x]) -> pointsMap[y]?[x] is n)


module.exports = {getCycle, getConnectedPoints, findNeighborsWithN}
