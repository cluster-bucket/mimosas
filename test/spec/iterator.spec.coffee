((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../mimosas'], factory
  else if typeof exports is 'object'
    lib = require '../../mimosas'
    module.exports = factory lib
  else
    factory root.Mimosas
) @, (Mimosas) ->

  describe 'Mimosas.Iterator', ->

    makeIterator = (items...) ->
      list = new Mimosas.List()
      iterator = new Mimosas.Iterator list
      for item in items
        list.append __POINTER__: item
      {iterator, list}

    it 'should exist', () ->
      expect(Mimosas.Iterator?).to.be.true

    it 'should be done when list is empty', () ->
      {iterator, list} = makeIterator()
      expect(iterator.isDone()).to.be.true

    it 'should throw when next is called on an empty list', () ->
      {iterator, list} = makeIterator()
      iterator.next()
      throwMe = ->
        iterator.currentItem()
      expect(throwMe).to.throw()

    it 'should not be done when created with a list that has one item', () ->
      {iterator, list} = makeIterator 'foo'
      expect(iterator.isDone()).to.be.false

    it 'should be done after calling next on a list that has one item', () ->
      {iterator, list} = makeIterator 'foo'
      iterator.next()
      expect(iterator.isDone()).to.be.true

    it 'should get the correct item after calling next', () ->
      {iterator, list} = makeIterator 'foo', 'bar'
      iterator.next()
      item = iterator.currentItem()
      expect(item.__POINTER__).to.equal 'bar'

    it 'should be done after removing all items from list', () ->
      {iterator, list} = makeIterator 'foo', 'bar'
      list.removeAll()
      expect(iterator.isDone()).to.be.true

    it 'should go back to the first item', () ->
      {iterator, list} = makeIterator 'foo', 'bar'
      iterator.next().first()
      item = iterator.currentItem()
      expect(item.__POINTER__).to.equal 'foo'

    it 'should throw when getting an item that is out of bounds', () ->
      {iterator, list} = makeIterator 'foo'
      iterator.next()
      iterator.next()
      throwMe = ->
        iterator.currentItem()
      expect(throwMe).to.throw


