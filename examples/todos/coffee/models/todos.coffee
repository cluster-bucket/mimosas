define ['mimosas', 'cs!./todo'], (Mimosas, Todo) ->

  class TodoList extends Mimosas.ModelSubject

    constructor: () ->
      @collection = new Mimosas.List()
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

    countUncompleted: () ->
      count = 0
      i = @getIterator()
      while not i.isDone()
        item = i.currentItem()
        count += 1 if item.getCompleted() is false
        i.next()
      count

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
      new Mimosas.Iterator @collection

    serialize: () ->
      serialized = []
      i = @getIterator()
      while not i.isDone()
        item = i.currentItem()
        serialized.push item.serialize()
        i.next()
      serialized
