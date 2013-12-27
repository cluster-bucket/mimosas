define ['mimosas/view_composite'], (ViewLeaf) ->
  class ShowTodoView extends ViewLeaf
  
    changed: (model) ->
      @display model
      
    display: (model) ->
      return unless model?
      className = ''
      className = 'completed' if model.getCompleted()
      @getElement().className = className