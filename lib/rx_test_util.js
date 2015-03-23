"use strict";
var Rx, assertRxActions, onCompleted, onNext, subscribe, ticksEqual;

Rx = require('rx');

onNext = Rx.ReactiveTest.onNext;

onCompleted = Rx.ReactiveTest.onCompleted;

subscribe = Rx.ReactiveTest.subscribe;

ticksEqual = function(expected, actual) {
  var i, j, ref;
  if (expected.length !== actual.length) {
    return false;
  }
  for (i = j = 0, ref = expected.length; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
    if (!Rx.internals.isEqual(expected[i], actual[i])) {
      return false;
    }
  }
  return true;
};

assertRxActions = function(actionSource, inputTicks, expectedTicks, cb) {
  var endTime, res, rxExpectedTicks, rxInputTicks, scheduler, startTime, ticksOk, xs;
  scheduler = new Rx.TestScheduler;
  startTime = inputTicks[0][0];
  endTime = inputTicks[inputTicks.length - 1][0] + 10;
  rxInputTicks = inputTicks.map(function(arg) {
    var data, time;
    time = arg[0], data = arg[1];
    return onNext(time, data);
  });
  rxInputTicks = rxInputTicks.concat([onCompleted(endTime)]);
  rxExpectedTicks = expectedTicks.map(function(arg) {
    var data, time;
    time = arg[0], data = arg[1];
    return onNext(time, data);
  });
  rxExpectedTicks = rxExpectedTicks.concat([onCompleted(endTime)]);
  xs = scheduler.createHotObservable.apply(scheduler, rxInputTicks);
  res = scheduler.startWithCreate(function() {
    return actionSource(xs);
  });
  ticksOk = ticksEqual(res.messages, rxExpectedTicks);
  return cb(ticksOk, res.messages, rxExpectedTicks, inputTicks, expectedTicks);
};

module.exports = {
  ticksEqual: ticksEqual,
  assertRxActions: assertRxActions
};
