define ['mimosas/controller_strategy'], (ControllerStrategy) ->
  class ShowTodoController extends ControllerStrategy
    events:
      'input[type="checkbox"]': 'click'
      
    onClick: (e) ->
      @getModel().setCompleted e.target.checked