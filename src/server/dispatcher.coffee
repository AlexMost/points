{createGame} = require '../engine/game'

# XXX: write tests + add "game existance check"
class Dispatcher
    constructor: (@appBus) ->
        @games = {}

    initGame: ->
        newGame = createGame()
        gameId = newGame.getId()
        @games[gameId] = newGame
        gameId

    joinClient: (gameId, playerId) ->
        game = @games[gameId]

        @appBus
        .filter(({game, from}) ->
            game is gameId and from is playerId)
        .subscribe(
            ({from, message}) ->
                game.sendMessage {from, message})

        game.getUpdateStream()
        .subscribe((state) => @appBus.onNext {
            game: gameId, to: playerId, state})


module.exports = Dispatcher