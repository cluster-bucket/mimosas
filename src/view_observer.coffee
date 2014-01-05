{Guid} = require './guid'

class ViewObserver
  constructor: () ->
    @__POINTER__ = Guid.generate()

  changed: (theChangedSubject) ->

exports.ViewObserver = ViewObserver
