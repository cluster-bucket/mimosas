define [
  'mimosas/controller_strategy'
], (ControllerStrategy) ->
  
  class NewSongController extends ControllerStrategy
    events: 
      '#new-song__form': 'submit'
      
    onSubmit: (e) ->
      e.preventDefault()
      console.log 'New song', e
