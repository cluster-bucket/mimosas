define ['mimosas/model_subject', 'cs!../models/song'], (ModelSubject, Song) ->
  
  class SongCollection extends ModelSubject
    constructor: () ->
      @collection = []
      super
    addSong: (data) ->
      if data?
        @collection.push new Song data
        @notify()
    getSongs: () ->
      @collection
      
    serialize: () ->
      songs = []
      for song in @collection
        songs.push song.serialize()
      songs
