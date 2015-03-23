"use strict";
var DEFAULT_HEIGHT, DEFAULT_WIDTH, GameState, Immutable, Map, Rx, addPointAction, createGame, initPointsMap;

Immutable = require('immutable');

Rx = require('rx');

GameState = require('./lib/game_state').GameState;

initPointsMap = require('./lib/point').initPointsMap;

addPointAction = require('./actions/add_point').addPointAction;

Map = Immutable.Map;

DEFAULT_WIDTH = 20;

DEFAULT_HEIGHT = 20;

createGame = function(initialData) {
  var eventStream, gameState, height, updateStream, width;
  eventStream = new Rx.Subject;
  initialData || (initialData = {});
  width = initialData.width || DEFAULT_WIDTH;
  height = initialData.height || DEFAULT_HEIGHT;
  gameState = new GameState({
    pointsMap: initPointsMap(width, height),
    width: width,
    height: height
  });
  updateStream = Rx.Observable.merge(Rx.Observable["return"]({
    action: "start",
    gameState: gameState
  }), addPointAction(eventStream))["do"](function(arg) {
    var newGameState;
    newGameState = arg.gameState;
    return gameState = gameState.merge(newGameState);
  });
  return {
    getUpdateStream: function() {
      return updateStream;
    },
    getGameState: function() {
      return gameState;
    },
    addPoint: function(x, y, player) {
      return eventStream.onNext({
        action: "addPoint",
        x: x,
        y: y,
        gameState: gameState,
        player: player
      });
    }
  };
};

module.exports = {
  createGame: createGame,
  initPointsMap: initPointsMap
};
