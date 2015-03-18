Immutable = require 'immutable'
{POINT_STATE} = require './game_state'


initPointsMap = (width, height) ->
    rawMap = {}
    for i in [0...width]
        rawMap[i] = {}
        for j in [0...  height]
            rawMap[i][j] = POINT_STATE.NOT_SET
    Immutable.fromJS rawMap


addPoint = (x, y, gameState) ->


module.exports = {initPointsMap}