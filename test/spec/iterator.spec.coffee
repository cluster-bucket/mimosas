((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/iterator', '../../bin/list'], factory
  else if typeof exports is 'object'
    Iterator = require '../../src/iterator.coffee'
    List = require '../../src/list.coffee'
    module.exports = factory List
  else
    Iterator = root.Mimosas.Iterator
    List = root.Mimosas.List
    factory Iterator, List
) @, (Iterator, List) ->

  describe 'List', ->

    makeIterator = (items...) ->
      list = new List()
      iterator = new Iterator list
      for item in items
        list.append __POINTER__: item
      {iterator, list}

  'should exist': (test) ->
    test.equal Iterator?, true
    test.done()

  'should be done when list is empty': (test) ->
    {iterator, list} = makeIterator()
    test.equal iterator.isDone(), true
    test.done()

  'should throw when next is called on an empty list': (test) ->
    {iterator, list} = makeIterator()
    test.throws () ->
      iterator.next()
      iterator.currentItem()
    test.done()

  'should not be done when created with a list that has one item': (test) ->
    {iterator, list} = makeIterator 'foo'
    test.equal iterator.isDone(), false
    test.done()

  'should be done after calling next on a list that has one item': (test) ->
    {iterator, list} = makeIterator 'foo'
    iterator.next()
    test.equal iterator.isDone(), true
    test.done()

  'should get the correct item after calling next': (test) ->
    {iterator, list} = makeIterator 'foo', 'bar'
    iterator.next()
    item = iterator.currentItem()
    test.equal item.__POINTER__, 'bar'
    test.done()

  'should be done after removing all items from list': (test) ->
    {iterator, list} = makeIterator 'foo', 'bar'
    list.removeAll()
    test.equal iterator.isDone(), true
    test.done()

  'should go back to the first item': (test) ->
    {iterator, list} = makeIterator 'foo', 'bar'
    iterator.next().first()
    item = iterator.currentItem()
    test.equal item.__POINTER__, 'foo'
    test.done()

  'should throw when getting an item that is out of bounds': (test) ->
    {iterator, list} = makeIterator 'foo'
    iterator.next()
    test.throws () ->
      iterator.next()
      iterator.currentItem()
    test.done()


