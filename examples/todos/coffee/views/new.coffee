# Nothing needs to be done in this view because its HTML already exists
# and it will always be visible.
define ['mimosas/view_leaf'], (ViewLeaf) ->
  class NewTodoView extends ViewLeaf
  
    # An error will be thrown from the page view if this is not present
    display: () ->