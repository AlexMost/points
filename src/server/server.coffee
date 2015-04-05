"use strict"

path = require 'path'
express = require 'express'
ReactEngine = require 'express-react-engine'
socket_io = require 'socket.io'
session = require 'express-session'
Rx = require 'rx'

app = express()

games = {}
gameActionBus = new Rx.Subject

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
    console.log "GET", req.session.id
    res.render('welcome_page', {
        name: "points",
        title: "points main stage"
    })
)

app.get('/create_game', (req, res) ->
    player1Session = req.session.id
    newGame = createGame(gameActionBus)
    games[newGame.getId()] = newGame
)

app.get('/game/:gameId', (req, res) ->
    gameId = req.params.gameId

    unless gameId of games
        return res.send(404)

    res.render(
        "main_stage"
        gameState: game[gameId]
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
    id = socket.request.session.id
    console.log "IO connection", id

    messageStream = gameActionBus
    .filter(({subject}) -> subject is socket.request.session.id)
    .subscribe(
        ({message}) -> socket.emit('message', message)
        (err) -> console.log err
    )

    socket.on('message', (message) ->
        gameActionBus.onNext {object: id, message}
    )

    socket.on('connect_game', (message) ->
        gameActionBus.onNext {subject: message.gameId, message}
    )
)



