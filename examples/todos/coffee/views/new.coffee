define ['mimosas', 'handlebars'], (Mimosas, Handlebars) ->

  class NewTodoView extends Mimosas.ViewLeaf

    # Nothing needs to be done to display this view because its HTML already
    # exists and is displayed on the page.
    # display: () ->

    clear: () ->
      @getElement().value = ''
