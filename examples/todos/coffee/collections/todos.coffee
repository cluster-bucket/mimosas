define ['mimosas/model_subject', 'cs!../models/todo'], (ModelSubject, Todo) ->
  
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
