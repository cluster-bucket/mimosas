define [
  'mimosas/model_subject'
  'mimosas/list'
  'mimosas/iterator'
  'cs!./todo'
], (ModelSubject, List, Iterator, Todo) ->

  class TodoList extends ModelSubject

    constructor: () ->
      @collection = new List()
      super

    setCompleted: (pointer, completed) ->
      item = @get pointer
      item.setCompleted completed
      @notify()

    setAllCompleted: (completed) ->
      i = @getIterator()
      while not i.isDone()
        i.currentItem().setCompleted completed
        i.next()
      @notify()

    append: (item) ->
      @collection.append item
      @notify()

    remove: (pointer) ->
      @collection.remove pointer
      @notify()

    get: (pointer) ->
      @collection.get pointer

    count: () ->
      @collection.count()

    getIterator: () ->
      new Iterator @collection

    serialize: () ->
      serialized = []
      i = @getIterator()
      while not i.isDone()
        item = i.currentItem()
        serialized.push item.serialize()
        i.next()
      serialized
