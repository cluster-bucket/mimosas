(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['../../dist/mimosas'], function(mimosas) {
    var SongList, _ref;

    return SongList = (function(_super) {
      __extends(SongList, _super);

      function SongList() {
        _ref = SongList.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      SongList.prototype.changed = function(songCollection) {
        var song, songs, _i, _len, _results;

        songs = songCollection.getSongs();
        _results = [];
        for (_i = 0, _len = songs.length; _i < _len; _i++) {
          song = songs[_i];
          _results.push(console.log("" + (song.getTitle()) + " by " + (song.getArtist())));
        }
        return _results;
      };

      return SongList;

    })(mimosas.Observer);
  });

}).call(this);
