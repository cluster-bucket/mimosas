define [
  'cs!collections/songs'
  'cs!views/song_list'
], (SongCollection, SongList) ->

  console.log "App Loaded"

  class App
    constructor: () ->
      @songs = new SongCollection()
      @songs.attach new SongList()

  app = new App()
  
  app.songs.addSong
    title: 'Time After Time'
    artist: 'Cyndi Lauper'
    album: 'She\'s So Unusual'

  app.songs.addSong
    title: 'You Belong to the City'
    artist: 'Glen Frey'
    album: 'Miami Vice Soundtrack'
