React = require 'react'

sanitizeOutputJson = (raw_json) ->
    raw_json.replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")


reactRender = (res, componentClass, props, templateProps) ->
    component = React.createElement(componentClass, props)
    str = React.renderToString component
    templateProps['reactOutput'] = str
    templateProps['componentData'] =
        sanitizeOutputJson(JSON.stringify props)
    res.render('layout', templateProps)


module.exports = {reactRender}