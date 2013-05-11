    define [
      'collections/songs'
      'views/song_list'
    ], (SongCollection, SongList) ->

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
