Observer = require '../src/observer'

exports.Observer =
  'should exist': (test) ->
    test.equal Observer?, true
    test.done()

  'should have a changed event': (test) ->
    observer = new Observer()
    test.equal observer.changed?, true
    test.done()