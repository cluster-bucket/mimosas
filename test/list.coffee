List = require '../src/list'

exports.List =
  setUp: (callback) ->
    this.list = new List()
    this.item = __POINTER__: 'bar'
    callback()

  tearDown: (callback) ->
    this.list = undefined
    this.item = undefined
    callback()

  'should exist': (test) ->
    test.equal List?, true
    test.done()

  'should have a zero count on init': (test) ->
    test.equal this.list.count(), 0
    test.done()

  'should throw when appending an item without a pointer': (test) ->
    delete this.item.__POINTER__
    test.throws () ->
      this.list.append(this.item)
    test.done()

  'should append an item': (test) ->
    this.list.append(this.item)
    test.equal this.list.count(), 1
    test.done()

  'should get an item by its index': (test) ->
    this.item.__POINTER__ = 'foo'
    this.list.append this.item
    item = this.list.getByIndex 0
    test.equal item.__POINTER__, 'foo'
    test.done()

  'should throw when getting an item by an index that doesn\'t exist': (test) ->
    test.throws () ->
      item = this.list.getByIndex 0
    test.done()

  'should get an item by its pointer': (test) ->
    this.list.append __POINTER__: 'foo'
    this.list.append __POINTER__: 'bar'
    item = this.list.get 'bar'
    test.equal item.__POINTER__, 'bar'
    test.done()

  'should get the first item in the list': (test) ->
    this.list.append __POINTER__: 'foo'
    this.list.append __POINTER__: 'bar'
    item = this.list.first()
    test.equal item.__POINTER__, 'foo'
    test.done()

  'should get the last item in the list': (test) ->
    this.list.append __POINTER__: 'foo'
    this.list.append __POINTER__: 'bar'
    item = this.list.last()
    test.equal item.__POINTER__, 'bar'
    test.done()

  'should throw when removing an item without a pointer': (test) ->
    delete this.item.__POINTER__
    test.throws () ->
      this.list.remove this.item
    test.done()

  'should remove an item from the list': (test) ->
    this.list.append __POINTER__: 'foo'
    this.list.append __POINTER__: 'bar'
    test.equals this.list.count(), 2
    this.list.remove 'bar'
    test.equals this.list.count(), 1
    test.done()

  'should remove the last item in the list': (test) ->
    this.list.append __POINTER__: 'foo'
    this.list.append __POINTER__: 'bar'
    test.equals this.list.count(), 2
    this.list.removeLast()
    test.equals this.list.count(), 1
    item = this.list.first()
    test.equal item.__POINTER__, 'foo'
    test.done()

  'should remove the first item in the list': (test) ->
    this.list.append __POINTER__: 'foo'
    this.list.append __POINTER__: 'bar'
    test.equals this.list.count(), 2
    this.list.removeFirst()
    test.equals this.list.count(), 1
    item = this.list.first()
    test.equal item.__POINTER__, 'bar'
    test.done()
