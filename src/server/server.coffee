"use strict"

path = require 'path'
express = require 'express'
ReactEngine = require 'express-react-engine'
socket_io = require 'socket.io'
session = require 'express-session'
Rx = require 'rx'
Dispatcher = require './dispatcher'
WelcomePage = require '../components/welcome_page'
MainStage = require '../components/main_stage'
{reactRender} = require './react_render'

app = express()

gameActionBus = new Rx.Subject
gameDispatcher = new Dispatcher gameActionBus

# template engine
app.set('view engine', 'jsx')
app.set('views', path.resolve(__dirname, '../components'))
app.set 'view engine', 'ejs'

# static folder settings
app.use(express.static(path.resolve __dirname, '../static'))

# session config
sessionMiddleware = session({secret: "my session secret"})
app.use(sessionMiddleware)


# simple http routes
app.get('/', (req, res) ->
    reactRender(
        res
        WelcomePage
        {}
        {
            title: "points create game page"
            initScript: "/js/welcome_page.js"
        }
    )
)

app.get('/create_game', (req, res) ->
    gameId = gameDispatcher.initGame()
    res.redirect("/join_game/#{gameId}")
)

app.get('/join_game/:gameId', (req, res) ->
    clientId = req.session.id
    gameId = req.params.gameId
    gameDispatcher.joinClient(gameId, clientId)
    res.redirect("/game/#{gameId}")
)

app.get('/game/:gameId', (req, res) ->
    gameId = req.params.gameId

    reactRender(
        res
        MainStage
        {
            gameState: gameDispatcher.getGameState(gameId).toJS()
            name: "new www"
        }
        {
            title: "points game"
            initScript: "/js/main_stage.js"   
        }
    )
)

# running app
server = app.listen 3000, ->
    console.log "app is listening ..."

# socket io
io = socket_io.listen(server)

io.use((socket, next) ->
    sessionMiddleware(
        socket.request,
        socket.request.res,
        next)
)

io.on('connection', (socket) ->
    socketId = socket.request.session.id
    gameId = null
    console.log "IO connection", socketId

    socket.on('message', ({game, message}) ->
        gameActionBus.onNext {
            from: socketId, game: gameId, message}
    )

    gameActionBus
    .filter(-> !! game)
    .filter(({to, game}) -> to is socketId and game is gameId)
    .subscribe(
        (data) -> socket.emit('update', data)
    )
)



