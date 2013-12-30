define [
  'mimosas/view_composite'
  'handlebars'
  'cs!controllers/show'
  'cs!views/show'
], (ViewLeaf, Handlebars, ShowTodoController, ShowTodoView) ->

  class ListTodosView extends ViewLeaf

    changed: (collection) ->
      @display collection
      ###
      for model in collection.getTodos()
        id = model.getPointer()
        showTodoView = new ShowTodoView "##{id}"
        showTodoView.setModel model
        showTodoView.setController new ShowTodoController()
      ###

    display: (collection) ->
      return unless collection?
      html = @toHtml collection.serialize()
      @getElement().innerHTML = html

    toHtml: (collection) ->
      template = @getTemplate()
      template todos: collection

    getTemplate: () ->
      source = document.getElementById('list-todos-template').innerHTML
      Handlebars.compile source

    getClosestItemId: (element) ->
      found = @closest element, 'todo'
      found.dataset['id'] if found

    closest: (element, className) ->
      return if element is @getElement()
      return element if @hasClass element, className
      parent = element.parentNode
      return @closest parent, className

    hasClass: (element, className) ->
      re = new RegExp "(\\s|^)#{className}(\\s|$)"
      element.className.match re

    elementMatchesSelector: (element, selector) ->
      matches = false
      for prefix in ['webkit', 'moz', 'ms']
        name = "#{prefix}MatchesSelector"
        continue unless element[name]
        matches = element[name] selector
      matches

    remove: (id) ->
      element = document.getElementById id
      element.remove()
