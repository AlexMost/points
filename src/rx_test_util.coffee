Rx = require 'rx'
onNext = Rx.ReactiveTest.onNext
onCompleted = Rx.ReactiveTest.onCompleted
subscribe = Rx.ReactiveTest.subscribe


ticksEqual = (expected, actual) ->
    if expected.length != actual.length
        return false

    for i in [0..expected.length]
        unless Rx.internals.isEqual expected[i], actual[i]
            return false
    true


assertRxActions = (actionSource, inputTicks, expectedTicks, cb) ->
    scheduler = new Rx.TestScheduler

    startTime = inputTicks[0][0]
    endTime = inputTicks[inputTicks.length - 1][0] + 10

    rxInputTicks = inputTicks.map ([time, data]) -> onNext(time, data)
    rxInputTicks = rxInputTicks.concat([onCompleted(endTime)])

    rxExpectedTicks = expectedTicks.map ([time, data]) -> onNext(time, data)
    rxExpectedTicks = rxExpectedTicks.concat([onCompleted(endTime)])

    xs = scheduler.createHotObservable rxInputTicks...
    res = scheduler.startWithCreate(-> actionSource(xs))

    ticksOk = ticksEqual(res.messages, rxExpectedTicks)

    cb(ticksOk, res.messages, rxExpectedTicks, inputTicks, expectedTicks)


module.exports = {ticksEqual, assertRxActions}
