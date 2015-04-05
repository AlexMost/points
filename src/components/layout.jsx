var React = require('react');

var Html = React.createClass({
  render: function () {
    return (
      <html>
        <head>
          <title>{this.props.props.title}</title>
          <link rel='stylesheet' type='text/css' href='/stylesheets/style.css' />
        </head>
        <body dangerouslySetInnerHTML={{__html: this.props.body}}>
        </body>
      </html>
    );
  }
});

module.exports = Html;