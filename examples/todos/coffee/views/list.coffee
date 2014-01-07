define ['mimosas', 'handlebars'], (Mimosas, Handlebars) ->

  class ListTodosView extends Mimosas.ViewLeaf

    changed: (model) ->
      @display()

    display: () ->
      @displayMain()
      @displayList()

    displayMain: () ->
      displayValue = 'block'
      displayValue = 'none' if @getModel().count() is 0
      @getElement().style.display = displayValue

    displayList: () ->
      html = @toHtml @getModel().serialize()
      list = @getElementFromSelector '#todo-list'
      list.innerHTML = html

    toHtml: (data) ->
      template = @getTemplate()
      template todos: data

    getTemplate: () ->
      source = document.getElementById('list-todos-template').innerHTML
      Handlebars.compile source
