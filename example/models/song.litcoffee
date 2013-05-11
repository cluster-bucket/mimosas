SongModel
=========

There's nothing special about this class really. It's just a regular old model.

    define [], () ->
      
      class SongModel
        constructor: (data) ->
          throw new Error 'UndefinedSong' unless data?
          throw new Error 'UndefinedSongTitle' unless data.title?
          throw new Error 'UndefinedSongArtist' unless data.artist?
          throw new Error 'UndefinedSongAlbum' unless data.album?

          @addTitle data.title
          @addArtist data.artist
          @addAlbum data.album

        addTitle: (@title) ->
        getTitle: () ->
          @title

        addArtist: (@artist) ->
        getArtist: () ->
          @artist

        addAlbum: (@album) ->
        getAlbum: () ->
          @album
