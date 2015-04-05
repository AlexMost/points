var React = require('react');

var WelcomePage = React.createClass({
  render: function() {
    return (
        <div>
            <a href="/create_game">Create game</a>
            <script src="/socket.io/socket.io.js"></script>
            <script src="js/welcome_page.js"></script>
        </div>
    );
  }
});

module.exports = WelcomePage;