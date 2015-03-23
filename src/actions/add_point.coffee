"use strict"

Rx = require 'rx'
{initPointsMap, addPoint, isValidPointRange,
isValidPlayer, isValidGameCycleForAddPoint,
isFreePoint} = require '../lib/point'
l = require 'lodash'


exports.addPointAction = (stream) ->
    Rx.Observable.create (observer) ->
        addPointSource = stream.filter(({action}) -> action is "addPoint")
        
        invalidPointRange = addPointSource
        .filter(({x, y, gameState}) -> !isValidPointRange(x, y, gameState))
        .map( -> {message: "is invalid point range", arguments})

        invalidPlayer = addPointSource
        .filter(({player, gameState}) -> !isValidPlayer(player, gameState))
        .map( -> {message: "is invalid player", arguments})

        invalidGameCycleForAddPoint = addPointSource
        .filter(({gameState}) -> !isValidGameCycleForAddPoint(gameState))
        .map( -> {message: "is invalid game cycle", arguments})

        notFreePoint = addPointSource
        .filter(({x, y, gameState}) -> !isFreePoint(x, y, gameState))
        .map( -> {message: "point is not free", arguments})
        
        # validation failure
        Rx.Observable
        .merge(invalidPointRange, invalidPlayer,
            invalidGameCycleForAddPoint, notFreePoint)
        .subscribe(
            (error_data) -> observer.onError error_data
            (err) -> observer.onError err)

        # validation success
        validPointRange = addPointSource
        .filter(({x, y, gameState}) -> isValidPointRange(x, y, gameState))
        .filter(({player, gameState}) -> isValidPlayer(player, gameState))
        .filter(({gameState}) -> isValidGameCycleForAddPoint(gameState))
        .filter(({x, y, gameState}) -> isFreePoint(x, y, gameState))
        .map(({x, y, player, gameState, action}) ->
            gameState = addPoint(x, y ,player, gameState)
            {gameState, action})
        .subscribe(observer)

