React = require 'react'
View = React.createFactory(require '../components/main_stage')

socket = io.connect('http://localhost:3000')

# viewInstance = React.render(
#     View()
#     document.body
# )

socket.on('update', (data) ->
    console.log data
)


