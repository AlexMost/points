"use strict";
var addPoint, initPointsMap, isFreePoint, isValidGameCycleForAddPoint, isValidPlayer, isValidPointRange, ref;

ref = require('../lib/point'), initPointsMap = ref.initPointsMap, addPoint = ref.addPoint, isValidPointRange = ref.isValidPointRange, isValidPlayer = ref.isValidPlayer, isValidGameCycleForAddPoint = ref.isValidGameCycleForAddPoint, isFreePoint = ref.isFreePoint;

exports.addPointAction = function(stream) {
  return stream.filter(function(arg) {
    var action, gameState, player, x, y;
    action = arg.action, x = arg.x, y = arg.y, player = arg.player, gameState = arg.gameState;
    return action === "addPoint" && isValidPointRange(x, y, gameState) && isValidPlayer(player, gameState) && isValidGameCycleForAddPoint(gameState) && isFreePoint(x, y, gameState);
  }).map(function(arg) {
    var action, gameState, point, x, y;
    x = arg.x, y = arg.y, point = arg.point, gameState = arg.gameState, action = arg.action;
    gameState = addPoint(x, y, point, gameState);
    return {
      gameState: gameState,
      action: action
    };
  });
};
