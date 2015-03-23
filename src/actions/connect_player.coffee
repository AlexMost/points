"use strict"

Rx = require 'rx'
{PLAYER} = require '../lib/game_state'

exports.connectPlayer = (stream) ->
    Rx.Observable.create (observer) ->
        connectPlayerSource = stream
        .filter(({action}) -> action is "connectPlayer")

        firstConnect = connectPlayerSource
        .filter(({player}) -> player is PLAYER.FIRST)
        .map(({player, gameState, action}) ->
            {gameState: gameState.set("playerFirstOn", true), action})

        secondConnect = connectPlayerSource
        .filter(({player}) -> player is PLAYER.SECOND)
        .map(({player, gameState, action}) ->
            {gameState: gameState.set("playerSecondOn", true), action})

        Rx.Observable.merge(firstConnect, secondConnect).subscribe observer
