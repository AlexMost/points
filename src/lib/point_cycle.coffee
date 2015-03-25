getCycle = (x, y, pointsMap) ->
    # connectedPoints = getConnectedPoints(x, y, pointsMap)


getConnectedPoints = (x, y, pointsMap) ->
    # connectedPoints = []

    # stack = []
    # stack.push [x, y]

    # while stack.length
    #     [current_x, current_y] = stack.pop()
    #     connectedPoints.push [current_x, current_y]
    #     neighbors = findNeighbors current_x, current_y, pointsMap
    #     for neighbor in neighbors
    #         stack.push neighbor

    # connectedPoints


findNeighborsWithN = (n, [x, y], pointsMap) ->
    [[x-1, y-1], [x, y-1], [x+1, y-1]
    [x-1, y],             [x+1, y]
    [x-1, y+1], [x, y+1], [x+1, y+1]]
    .filter(([x, y]) -> x >= 0 and y >= 0)
    .map(([x, y]) -> [x, y, pointsMap[y][x]])
    .filter(([x, y, val]) -> val is n)
    .map(([x, y]) -> [x, y])


module.exports = {getCycle, getConnectedPoints, findNeighborsWithN}
