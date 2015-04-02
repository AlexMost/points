express = require 'express'
ReactEngine = require 'express-react-engine'


app = express()
app.set('views', __dirname + '/components')
app.set('view engine', 'jsx')
app.engine('jsx', ReactEngine({wrapper: 'layout.jsx'}))


app.get('/', (req, res) ->
    res.render('main_stage', {
        name: "points",
        title: "points main stage"
    })
)

server = app.listen 3000, ->
    console.log "app is listening ..."
