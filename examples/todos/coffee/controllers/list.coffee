define ['mimosas/controller_strategy'], (ControllerStrategy) ->

  class ListTodosController extends ControllerStrategy

    destroyClicked: (e) ->
      id = @getView().getClosestItemId e.target
      @getModel().remove id

    toggleClicked: (e) ->
      id = @getView().getClosestItemId e.target
      @getModel().setCompleted id, e.target.checked
