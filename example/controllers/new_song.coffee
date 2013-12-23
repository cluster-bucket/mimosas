define [
  'mimosas/strategy'
], (Strategy) ->
  
  class NewSongController extends Strategy
    events: 
      '#new-song__form': 'submit'
      
    onSubmit: (e) ->
      e.preventDefault()
      console.log 'New song', e
