define ['mimosas/subject', 'cs!../models/song'], (Subject, Song) ->
  
  class SongCollection extends Subject
    constructor: () ->
      @collection = []
      super
    addSong: (data) ->
      if data?
        @collection.push new Song data
        @notify()
    getSongs: () ->
      @collection
