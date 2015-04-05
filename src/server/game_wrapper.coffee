{createGame} = require '../game'

class GameWrapper
    constructor: ->
        @gameObj = createGame()

    joinPlayer: (sessionId) ->


module.exports = GameWrapper