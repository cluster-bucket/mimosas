define ['mimosas/controller_strategy'], (ControllerStrategy) ->

  ENTER_KEY = 13
  
  class NewTodoController extends ControllerStrategy
    events: 
      '#new-todo': 'keypress'
      
    onKeypress: (e) ->
      key = e.which or e.keyCode
      return unless key is ENTER_KEY
      @getModel().addTodo
        title: e.target.value
        completed: false
