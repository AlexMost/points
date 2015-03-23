"use strict"

Rx = require 'rx'
{createGame} = require '../../src/game'
{startGame} = require '../../src/actions/start_game'
{GAME_CYCLE} = require '../../src/lib/game_state'


exports.test_start_game = (test) ->
    gameInstance = createGame {width: 5, height: 5}
    eventStream = new Rx.Subject
    source = startGame eventStream
    source.subscribe(
        ({gameState}) ->
            test.equals(
                gameState.get("gameCycle"), GAME_CYCLE.ON_AIR,
                "must be on air game state")
            test.done()
        (err) -> throw err
    )

    eventStream.onNext {
        action: "startGame", gameState: gameInstance.getGameState()}


