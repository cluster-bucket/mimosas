define ['mimosas/controller_strategy'], (ControllerStrategy) ->
  class ShowTodoController extends ControllerStrategy
    toggleClicked: (e) ->
      @getModel().setCompleted e.target.checked

