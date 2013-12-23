define [
  'mimosas/controller_strategy'
], (ControllerStrategy) ->
  
  class NewSongController extends ControllerStrategy
    events: 
      '#new-song__form': 'submit'
      
    onSubmit: (e) ->
      e.preventDefault()
      
      model = {}
      for element in e.target.elements
        continue unless element.name
        model[element.name] = element.value
      
      @getModel().addSong model
