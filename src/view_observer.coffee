{Guid} = require './guid'

class exports.ViewObserver
  constructor: () ->
    @__POINTER__ = Guid.generate()

  changed: (theChangedSubject) ->
