"use strict"

Rx = require 'rx'
{GAME_CYCLE} = require "../lib/game_state"

# TODO: add check if 2 players are connected.
exports.startGame = (stream) ->
    Rx.Observable.create (observer) ->
        startGameSource = stream
        .filter(({action}) -> action is "startGame")
        .map(({action, gameState}) ->
            newGameState = gameState.set("gameCycle", GAME_CYCLE.ON_AIR)
            {gameState: newGameState, action})

        startGameSource.subscribe observer

