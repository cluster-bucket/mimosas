define [
  'mimosas/leaf'
  'handlebars'
], (Leaf, Handlebars) ->
  
  class NewSongView extends Leaf

    display: (collection) ->
      @getElement().innerHTML = @toHtml()

    toHtml: (collection) ->
      template = @getTemplate()
      template()

    getTemplate: () ->
      source = document.getElementById('new-song-template').innerHTML
      Handlebars.compile source
      