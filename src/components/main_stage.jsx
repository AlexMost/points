var React = require('react');

var MainStage = React.createClass({
  render: function() {
    return (
        <div>
            <h1>Main Stage</h1>
            <div>{this.props.gameState.gameCycle}</div>
            <div>Hello {this.props.name}</div>
            <script src="/socket.io/socket.io.js"></script>
        </div>
    );
  }
});

module.exports = MainStage;