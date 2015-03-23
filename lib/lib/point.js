"use strict";
var GAME_CYCLE, Immutable, PLAYER, POINT_STATE, addPoint, initPointsMap, isFreePoint, isValidGameCycleForAddPoint, isValidPlayer, isValidPointRange, ref;

Immutable = require('immutable');

ref = require('./game_state'), POINT_STATE = ref.POINT_STATE, PLAYER = ref.PLAYER, GAME_CYCLE = ref.GAME_CYCLE;

initPointsMap = function(width, height) {
  var i, j, k, l, rawMap, ref1, ref2;
  rawMap = {};
  for (i = k = 0, ref1 = width; 0 <= ref1 ? k < ref1 : k > ref1; i = 0 <= ref1 ? ++k : --k) {
    rawMap[i] = {};
    for (j = l = 0, ref2 = height; 0 <= ref2 ? l < ref2 : l > ref2; j = 0 <= ref2 ? ++l : --l) {
      rawMap[i][j] = POINT_STATE.NOT_SET;
    }
  }
  return Immutable.fromJS(rawMap);
};

addPoint = function(x, y, player, gameState) {
  var newPlayer;
  newPlayer = gameState.get("player") === PLAYER.FIRST ? PLAYER.SECOND : PLAYER.FIRST;
  return gameState.updateIn(["pointsMap", "" + x, "" + y], function() {
    return player;
  }).set("player", newPlayer);
};

isValidPointRange = function(x, y, gameState) {
  var height, width;
  width = gameState.get("width");
  height = gameState.get("height");
  return x <= width && y <= height && x >= 0 && y >= 0;
};

isValidPlayer = function(player, gameState) {
  var currentPlayer;
  currentPlayer = gameState.get("player");
  return player === currentPlayer;
};

isValidGameCycleForAddPoint = function(gameState) {
  return GAME_CYCLE.ON_AIR === gameState.get("gameCycle");
};

isFreePoint = function(x, y, gameState) {
  var point;
  point = gameState.getIn(["pointsMap", "" + x, "" + y]);
  return point === POINT_STATE.NOT_SET;
};

module.exports = {
  initPointsMap: initPointsMap,
  addPoint: addPoint,
  isValidPointRange: isValidPointRange,
  isValidPlayer: isValidPlayer,
  isValidGameCycleForAddPoint: isValidGameCycleForAddPoint,
  isFreePoint: isFreePoint
};
