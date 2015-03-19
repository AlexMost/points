Rx = require 'rx'
onNext = Rx.ReactiveTest.onNext
onCompleted = Rx.ReactiveTest.onCompleted
{ticksEqual, assertRxActions} = require '../src/rx_test_util'


exports.test_ticks_equal_numbers = (test) ->
    is_equal = ticksEqual(
        [onNext(100, 100), onNext(200, 200)]
        [onNext(100, 100), onNext(200, 200)]
    )
    test.ok is_equal, "must be equal ticks numbers"

    isnt_equal = ticksEqual(
        [onNext(100, 100), onNext(200, 200)]
        [onNext(100, 10), onNext(200, 200)]
    )

    test.ok !isnt_equal, "must be not equal ticks numbers"
    test.done()


exports.test_ticks_equal_objects = (test) ->
    obj1 = {a:{b:6}, c:7, d:{g:[1, 2, 3]}}
    obj1_res = {a:{b:6}, c:7, d:{g:[1, 2, 3]}}

    obj2 = {c:7, d:{g:[3, 2, 3]}}
    obj2_res = {c:7, d:{g:[3, 2, 3]}}

    is_equal = ticksEqual(
        [onNext(100, obj1), onNext(200, obj2)]
        [onNext(100, obj1_res), onNext(200, obj2_res)]
    )

    test.ok is_equal, "must be equal ticks objects"

    isnt_equal = ticksEqual(
        [onNext(100, obj1), onNext(200, obj1)]
        [onNext(100, obj2), onNext(200, obj1)]
    )

    test.ok !isnt_equal, "must be not equal ticks objects"
    test.done()


exports.test_assert_rx_actions = (test) ->
    actionSource = (stream) -> stream.map (x) -> x * 2
    assertRxActions(
        actionSource,
        [[210, 1], [220, 2]]
        [[210, 2], [220, 4]]
        (isEqual) ->
            test.ok isEqual, "must be equal sequences"
            test.done()
    )
