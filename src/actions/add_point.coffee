{initPointsMap, addPoint, isValidPointRange,
isValidPlayer, isValidGameCycleForAddPoint} = require '../lib/point'


exports.addPointAction = (stream) ->
    stream
    .filter(({action, x, y, player, gameState}) ->
        action is "addPoint" and
        isValidPointRange(x, y, gameState) and
        isValidPlayer(player, gameState) and
        isValidGameCycleForAddPoint gameState)
    .map(({x, y, point, gameState, action}) ->
        gameState = addPoint(x, y ,point, gameState)
        {gameState, action}
    )