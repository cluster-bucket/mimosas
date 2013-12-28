define ['mimosas/controller_strategy'], (ControllerStrategy) ->
  class ShowTodoController extends ControllerStrategy
    init: () ->
      @addEvent 'click', 'input[type="checkbox"]', 'checkboxClicked'
      
    checkboxClicked: (e) ->
      @getModel().setCompleted e.target.checked