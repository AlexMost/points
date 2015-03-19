Immutable = require 'immutable'
Rx = require 'rx'
{GameState} = require './lib/game_state'
{initPointsMap} = require './lib/point'
{addPointAction} = require './actions/add_point'


Map = Immutable.Map
DEFAULT_WIDTH = 20
DEFAULT_HEIGHT = 20


createGame = (initialData) ->
    eventStream = new Rx.Subject

    initialData or= {}
    width = initialData.width or DEFAULT_WIDTH
    height = initialData.height or DEFAULT_HEIGHT

    gameState = new GameState({
        pointsMap: initPointsMap(width, height)
        width
        height
    })

    updateStream = Rx.Observable
    .merge(
        Rx.Observable.return({action: "start", gameState})
        addPointAction(eventStream))
    .do(({gameState: newGameState}) ->
        gameState = gameState.merge newGameState)

    getUpdateStream: -> updateStream
    getGameState: -> gameState
    addPoint: (x, y, point, player) ->
        eventStream.onNext {action: "addPoint", x, y, gameState}


module.exports = {createGame, initPointsMap}