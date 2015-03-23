"use strict";
var END_GAME, FIRST, GAME_CYCLE, GameState, Immutable, Map, ON_AIR, PLAYER, POINT_STATE, Record, SECOND, START_GAME, ref, ref1;

Immutable = require('immutable');

Record = Immutable.Record;

Map = Immutable.Map;

ref = [0, 1, 2], START_GAME = ref[0], ON_AIR = ref[1], END_GAME = ref[2];

GAME_CYCLE = {
  START_GAME: START_GAME,
  ON_AIR: ON_AIR,
  END_GAME: END_GAME
};

ref1 = [1, 2], FIRST = ref1[0], SECOND = ref1[1];

PLAYER = {
  FIRST: FIRST,
  SECOND: SECOND
};

POINT_STATE = {
  NOT_SET: 0,
  FIRST: FIRST,
  SECOND: SECOND
};

GameState = Record({
  pointsMap: Map({}),
  width: 0,
  height: 0,
  gameCycle: GAME_CYCLE.START_GAME,
  player: PLAYER.FIRST
});

module.exports = {
  GAME_CYCLE: GAME_CYCLE,
  PLAYER: PLAYER,
  GameState: GameState,
  POINT_STATE: POINT_STATE
};
