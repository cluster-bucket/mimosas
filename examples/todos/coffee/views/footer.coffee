define ['mimosas', 'handlebars'], (Mimosas, Handlebars) ->

  class FooterView extends Mimosas.ViewLeaf

    changed: (model) ->
      @display()

    display: () ->
      @displayFooter()
      @displayCount()

    displayFooter: () ->
      displayValue = 'block'
      displayValue = 'none' if @getModel().count() is 0
      @getElement().style.display = displayValue

    displayCount: () ->
      element = @getElementFromSelector '#todo-count'
      html = @getCountHtml @getModel().countUncompleted()
      element.innerHTML = html

    getCountHtml: (count) ->
      plural = true
      plural = false if count is 1
      template = @getCountTemplate()
      template {count, plural}

    getCountTemplate: () ->
      source = document.getElementById('todo-count-template').innerHTML
      Handlebars.compile source
