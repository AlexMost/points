Immutable = require 'immutable'
Rx = require 'rx'
Map = Immutable.Map
{GAME_CYCLE, GameState, POINT_STATE} = require './game_state'

DEFAULT_WIDTH = 20
DEFAULT_HEIGHT = 20


initPointsMap = (width, height) ->
    rawMap = {}
    for i in [0...width]
        rawMap[i] = {}
        for j in [0...height]
            rawMap[i][j] = POINT_STATE.NOT_SET
    Immutable.fromJS rawMap


createGame = (initialData) ->
    initialData or= {}
    width = initialData.width or DEFAULT_WIDTH
    height = initialData.height or DEFAULT_HEIGHT

    eventStream = new Rx.Subject
    gameState = new GameState
    gameState = gameState.set(
        "pointsMap", initPointsMap(width, height))

    updateStream = Rx.Observable
    .merge(
        Rx.Observable.return({action: "start", gameState}))
    .share()

    getUpdateStream: -> updateStream


module.exports = {createGame, initPointsMap}