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
      
    serialize: () ->
      songs = []
      for song in @collection
        songs.push song.serialize()
      songs
