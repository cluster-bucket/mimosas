define [
  'mimosas/controller_strategy'
], (ControllerStrategy) ->

  class ToggleTodosController extends ControllerStrategy

    toggleAllClicked: (e) ->
      completed = e.target.checked
      @getModel().setAllCompleted completed
