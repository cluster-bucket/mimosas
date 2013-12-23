((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/list'], factory
    return
  else if typeof exports is 'object'
    List = require '../../src/list.coffee'
    module.exports = factory List
    return
  else
    List = root.Mimosas.List
    factory List
    return
) @, (List) ->

  describe 'List', ->

    list = undefined

    getTestItem = (pointer) ->
      __POINTER__: pointer
      getType: ->
        pointer

    # pointer[, pointer[, ...]]]
    appendTestItems = (pointers...) ->
      for pointer in pointers
        item = getTestItem pointer
        list.append item

    beforeEach ->
      list = new List()

    afterEach ->
      list = undefined

    it 'should exist', ->
      expect(List).to.exist

    it 'should have a zero count on init', ->
      expect(list.count()).to.equal 0

    it 'should throw when appending an item without a pointer', ->
      throwMe = ->
        list.append {}
      expect(throwMe).to.throw()

    it 'should append an item', ->
      item = getTestItem('foo')
      list.append item
      expect(list.count()).to.equal 1

    it 'should get an item by its index', ->
      appendTestItems 'foo'
      item = list.getByIndex(0)
      expect(item.__POINTER__).to.equal 'foo'

    it 'should throw when getting an item by an index that doesn\'t exist', ->
      throwMe = ->
        list.getByIndex 0
      expect(throwMe).to.throw()

    it 'should throw when getting an item by a negative index', ->
      throwMe = ->
        list.getByIndex -1
      expect(throwMe).to.throw()

    it 'should get an item by its pointer', ->
      appendTestItems 'foo', 'bar'
      item = list.get('bar')
      expect(item.__POINTER__).to.equal 'bar'

    it 'should get the first item in the list', ->
      appendTestItems 'foo', 'bar'
      item = list.first()
      expect(item.__POINTER__).to.equal 'foo'

    it 'should get the last item in the list', ->
      appendTestItems 'foo', 'bar'
      item = list.last()
      expect(item.__POINTER__).to.equal 'bar'

    it 'should throw when removing an item that doesn\'t exist', ->
      throwMe = ->
        list.remove 'baz'
      expect(throwMe).to.throw()

    it 'should remove an item from the list', ->
      appendTestItems 'foo', 'bar'
      expect(list.count()).to.equal 2
      list.remove 'bar'
      expect(list.count()).to.equal 1

    it 'should remove the last item in the list', ->
      appendTestItems 'foo', 'bar'
      expect(list.count()).to.equal 2
      list.removeLast()
      expect(list.count()).to.equal 1
      item = list.first()
      expect(item.__POINTER__).to.equal 'foo'

    it 'should remove the first item in the list', ->
      appendTestItems 'foo', 'bar'
      expect(list.count()).to.equal 2
      list.removeFirst()
      expect(list.count()).to.equal 1
      item = list.first()
      expect(item.__POINTER__).to.equal 'bar'

    it 'should remove all items from the list', ->
      appendTestItems 'foo', 'bar'
      expect(list.count()).to.equal 2
      list.removeAll()
      expect(list.count()).to.equal 0

  return

