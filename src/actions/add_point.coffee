{initPointsMap, addPoint, isValidPointRange,
isValidPlayer} = require '../lib/point'

exports.addPointAction = (stream) ->
    stream
    .filter(({action}) -> action is "addPoint")
    .filter(({x, y, player, gameState}) -> isValidPointRange x, y, gameState)
    .filter(({player, gameState}) -> isValidPlayer player, gameState)
    .map(({x, y, point, gameState, action}) ->
        gameState = addPoint(x, y ,point, gameState)
        {gameState, action})