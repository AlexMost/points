Rx = require 'rx'
{connectPlayer} = require '../../src/engine/actions/connect_player'
{createGame} = require '../../src/engine/game'
{PLAYER} = require '../../src/engine/lib/game_state'


exports.test_connect_player1 = (test) ->
    gameInstance = createGame {width: 5, height: 5}
    eventStream = new Rx.Subject
    source = connectPlayer eventStream

    source.subscribe(
        ({gameState}) ->
            test.ok(
                gameState.get("playerFirstOn"),
                "first player must be on")
            test.done()
        (err) -> throw err
    )

    eventStream.onNext {
        action: "connectPlayer",
        gameState: gameInstance.getGameState()
        player: PLAYER.FIRST}


exports.test_connect_player2 = (test) ->
    gameInstance = createGame {width: 5, height: 5}
    eventStream = new Rx.Subject
    source = connectPlayer eventStream

    source.subscribe(
        ({gameState}) ->
            test.ok(
                gameState.get("playerSecondOn"),
                "second player must be on")
            test.done()
        (err) -> throw err
    )

    eventStream.onNext {
        action: "connectPlayer",
        gameState: gameInstance.getGameState()
        player: PLAYER.SECOND}
