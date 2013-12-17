((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['list'], factory
  else if typeof exports is 'object'
    module.exports = factory(require('../../src/list.coffee'))
  else
    root.MimosasSpec = {} unless root.MimosasSpec?
    root.MimosasSpec.List = factory(root.Mimosas.List)
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

    it 'should exist', (test) ->
      expect(List).toBeDefined()

    it 'should have a zero count on init', (test) ->
      expect(list.count()).toEqual 0

    it 'should throw when appending an item without a pointer', (test) ->
      throwMe = ->
        list.append {}
      expect(throwMe).toThrow()

    it 'should append an item', (test) ->
      item = getTestItem('foo')
      list.append item
      expect(list.count()).toEqual 1

    it 'should get an item by its index', (test) ->
      appendTestItems 'foo'
      item = list.getByIndex(0)
      expect(item.__POINTER__).toBe 'foo'

    it 'should throw when getting an item by an index that doesn\'t exist', (test) ->
      throwMe = ->
        list.getByIndex 0
      expect(throwMe).toThrow()

    it 'should throw when getting an item by a negative index', (test) ->
      throwMe = ->
        list.getByIndex -1
      expect(throwMe).toThrow()

    it 'should get an item by its pointer', (test) ->
      appendTestItems 'foo', 'bar'
      item = list.get('bar')
      expect(item.__POINTER__).toBe 'bar'

    it 'should get the first item in the list', (test) ->
      appendTestItems 'foo', 'bar'
      item = list.first()
      expect(item.__POINTER__).toBe 'foo'

    it 'should get the last item in the list', (test) ->
      appendTestItems 'foo', 'bar'
      item = list.last()
      expect(item.__POINTER__).toBe 'bar'

    it 'should throw when removing an item that doesn\'t exist', (test) ->
      throwMe = ->
        list.remove 'baz'
      expect(throwMe).toThrow()

    it 'should remove an item from the list', (test) ->
      appendTestItems 'foo', 'bar'
      expect(list.count()).toEqual 2
      list.remove 'bar'
      expect(list.count()).toEqual 1

    it 'should remove the last item in the list', (test) ->
      appendTestItems 'foo', 'bar'
      expect(list.count()).toEqual 2
      list.removeLast()
      expect(list.count()).toEqual 1
      item = list.first()
      expect(item.__POINTER__).toBe 'foo'

    it 'should remove the first item in the list', (test) ->
      appendTestItems 'foo', 'bar'
      expect(list.count()).toEqual 2
      list.removeFirst()
      expect(list.count()).toEqual 1
      item = list.first()
      expect(item.__POINTER__).toBe 'bar'

    it 'should remove all items from the list', (test) ->
      appendTestItems 'foo', 'bar'
      expect(list.count()).toEqual 2
      list.removeAll()
      expect(list.count()).toEqual 0


  return

