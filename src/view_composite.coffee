{ViewComponent} = require './view_component'
{List} = require './list'

class ViewComposite extends ViewComponent
  constructor: () ->
    super
    @list = new List()

  add: (component) ->
    @list.append component

  remove: (pointer) ->
    @list.remove pointer

exports.ViewComposite = ViewComposite
