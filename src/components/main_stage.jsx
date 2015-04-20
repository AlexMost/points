var React = require('react');

var HelloMessage = React.createClass({
  render: function() {
    return (
        <div>
            <h1>Main Stage</h1>
            <div>Hello {this.props.name}</div>
            <script src="/socket.io/socket.io.js"></script>
            <script src='/js/main_stage.js' />
        </div>
    );
  }
});

module.exports = HelloMessage;