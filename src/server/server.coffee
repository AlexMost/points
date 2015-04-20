"use strict"

path = require 'path'
express = require 'express'
ReactEngine = require 'express-react-engine'
socket_io = require 'socket.io'
session = require 'express-session'
Rx = require 'rx'
Dispatcher = require './dispatcher'

app = express()

gameActionBus = new Rx.Subject
gameDispatcher = new Dispatcher gameActionBus

# template engine
app.set('view engine', 'jsx')
app.set('views', path.resolve(__dirname, '../components'))
app.engine('jsx', ReactEngine({wrapper: 'layout.jsx'}))

# static folder settings
app.use(express.static(path.resolve __dirname, '../static'))

# session config
sessionMiddleware = session({secret: "my session secret"})
app.use(sessionMiddleware)


# simple http routes
app.get('/', (req, res) ->
    res.render('welcome_page', {
        name: "points",
        title: "points main stage"
    })
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

    res.render(
        "main_stage"
        gameState: gameId
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
        game or= game # init game id on first message
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



