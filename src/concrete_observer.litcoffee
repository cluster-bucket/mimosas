
    # * Maintains a reference to a ConcreteSubject object
    # * Stores state that should stay consistent with
    #   the subject's
    # * Implements the Observer updating interface to keep
    #   its state consistent with the subject's
    class ConcreteObserver extends Observer
      update: (theChangedSubject) ->
        console.log "Updated"