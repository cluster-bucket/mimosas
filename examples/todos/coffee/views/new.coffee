define ['mimosas/view_leaf'], (ViewLeaf) ->

  class NewTodoView extends ViewLeaf

    # Nothing needs to be done to display this view because its HTML already
    # exists and is displayed on the page.
    # display: () ->

    clear: () ->
      @getElement().value = ''
