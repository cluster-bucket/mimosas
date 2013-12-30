define [
  'mimosas/model_subject'
  'mimosas/list'
  'mimosas/iterator'
  'cs!../models/todo'
], (ModelSubject, List, Iterator, Todo) ->

  class TodoList extends ModelSubject

    constructor: () ->
      @collection = new List()
      super

    setCompleted: (pointer, completed) ->
      item = @get pointer
      item.setCompleted completed
      @notify()

    append: (item) ->
      @collection.append item
      @notify()

    remove: (pointer) ->
      @collection.remove pointer
      @notify()

    get: (pointer) ->
      @collection.get pointer

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

  ###
  class Todos extends ModelSubject
    constructor: () ->
      @collection = []
      super

    addTodo: (data) ->
      if data?
        @collection.push new Todo data
        @notify()

    getTodos: () ->
      @collection

    serialize: () ->
      todos = []
      for todo in @collection
        todos.push todo.serialize()
      todos
  ###
