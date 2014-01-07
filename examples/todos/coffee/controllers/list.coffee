define ['mimosas'], (Mimosas) ->

  class ListTodosController extends Mimosas.ControllerStrategy

    destroyClicked: (e) ->
      element = @getView().closest e.target, '.todo'
      pointer = element.dataset['id']
      @getModel().remove pointer

    toggleClicked: (e) ->
      element = @getView().closest e.target, '.todo'
      pointer = element.dataset['id']
      completed = e.target.checked
      @getModel().setCompleted pointer, completed

    toggleAllClicked: (e) ->
      completed = e.target.checked
      @getModel().setAllCompleted completed
