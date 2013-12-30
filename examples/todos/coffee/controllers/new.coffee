define [
  'mimosas/controller_strategy'
  'cs!../models/todo'
], (ControllerStrategy, Todo) ->

  ENTER_KEY = 13

  class NewTodoController extends ControllerStrategy

    inputChanged: (e) ->
      key = e.which or e.keyCode
      return unless key is ENTER_KEY
      todo = new Todo
        title: e.target.value
        completed: false
      @getModel().append todo
      @getView().clear()
