define ['mimosas/view_leaf'], (ViewLeaf) ->

  class FooterView extends ViewLeaf

    changed: (model) ->
      @display()

    display: () ->
      @toggleDisplay()

    toggleDisplay: () ->
      displayValue = 'block'
      displayValue = 'none' if @getModel().count() is 0
      @getElement().style.display = displayValue

