{Guid} = require './guid'

class ViewObserver
  constructor: () ->
    @__POINTER__ = Guid.generate()

  changed: (theChangedSubjectAspects...) ->

exports.ViewObserver = ViewObserver
