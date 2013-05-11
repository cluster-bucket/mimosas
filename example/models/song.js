(function() {
  define([], function() {
    var SongModel;

    return SongModel = (function() {
      function SongModel(data) {
        if (data == null) {
          throw new Error('UndefinedSong');
        }
        if (data.title == null) {
          throw new Error('UndefinedSongTitle');
        }
        if (data.artist == null) {
          throw new Error('UndefinedSongArtist');
        }
        if (data.album == null) {
          throw new Error('UndefinedSongAlbum');
        }
        this.addTitle(data.title);
        this.addArtist(data.artist);
        this.addAlbum(data.album);
      }

      SongModel.prototype.addTitle = function(title) {
        this.title = title;
      };

      SongModel.prototype.getTitle = function() {
        return this.title;
      };

      SongModel.prototype.addArtist = function(artist) {
        this.artist = artist;
      };

      SongModel.prototype.getArtist = function() {
        return this.artist;
      };

      SongModel.prototype.addAlbum = function(album) {
        this.album = album;
      };

      SongModel.prototype.getAlbum = function() {
        return this.album;
      };

      return SongModel;

    })();
  });

}).call(this);
