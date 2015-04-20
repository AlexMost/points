"use strict"

Immutable = require 'immutable'
Rx = require 'rx'
get_uuid = require 'node-uuid'

{GameState, GAME_CYCLE} = require './lib/game_state'
{initPointsMap} = require './lib/point'
{addPointAction} = require './actions/add_point'
{startGame} = require './actions/start_game'
{connectPlayer} = require './actions/connect_player'

Map = Immutable.Map
DEFAULT_WIDTH = 20
DEFAULT_HEIGHT = 20


createGame = (initialData) ->
    uuid = get_uuid.v1()

    eventStream = new Rx.Subject

    initialData or= {}
    width = initialData.width or DEFAULT_WIDTH
    height = initialData.height or DEFAULT_HEIGHT
    gameCycle = initialData.gameCycle or GAME_CYCLE.START_GAME

    gameState = new GameState({
        pointsMap: initPointsMap(width, height)
        width
        height
        gameCycle
    })

    updateStream = Rx.Observable
    .merge(
        Rx.Observable.return({action: "start", gameState})
        addPointAction(eventStream)
        startGame(eventStream)
        connectPlayer(eventStream))
    .do(({gameState: newGameState}) ->
        gameState = gameState.merge newGameState)

    getUpdateStream: -> updateStream
    
    getGameState: -> gameState

    addPoint: (x, y, player) ->
        eventStream.onNext {action: "addPoint", x, y, gameState, player}

    startGame: ->
        eventStream.onNext {action: "startGame", gameState}

    connectPlayer: (player) ->
        eventStream.onNext {action: "connectPlayer", player, gameState}

    getId: -> uuid


module.exports = {createGame, initPointsMap}