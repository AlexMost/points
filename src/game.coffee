Immutable = require 'immutable'
Rx = require 'rx'
{GameState} = require './lib/game_state'
{initPointsMap} = require './lib/point'

Map = Immutable.Map
DEFAULT_WIDTH = 20
DEFAULT_HEIGHT = 20


createGame = (initialData) ->
    initialData or= {}
    width = initialData.width or DEFAULT_WIDTH
    height = initialData.height or DEFAULT_HEIGHT

    eventStream = new Rx.Subject
    gameState = new GameState({
        pointsMap: initPointsMap(width, height)
        width
        height
    })

    updateStream = Rx.Observable
    .merge(
        Rx.Observable.return({action: "start", gameState}))
    .share()

    getUpdateStream: -> updateStream
    getGameState: -> gameState


module.exports = {createGame, initPointsMap}