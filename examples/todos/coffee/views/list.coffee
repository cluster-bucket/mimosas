define [
  'mimosas/view_composite'
  'handlebars'
  'cs!controllers/show'
  'cs!views/show'
], (ViewLeaf, Handlebars, ShowTodoController, ShowTodoView) ->
  
  class ListTodosView extends ViewLeaf

    changed: (collection) ->
      @display collection
      for model in collection.getTodos()
        id = model.getPointer()
        showTodoView = new ShowTodoView "##{id}"
        showTodoView.setModel model
        showTodoView.setController new ShowTodoController()

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