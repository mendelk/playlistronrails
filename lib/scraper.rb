require 'find'
class Scraper
  class << self
    def get_files(directory)
      Find.find(directory).inject([]){|memo, file| memo << file.split("/").last if file.match(/\.mp3\Z/); memo}
    end
    def extract_info(file)
      regex = file.match(/(?<artist_song>.*)\[(?<genre>.+)\]/)
      artist_name, song_name = regex[:artist_song].split(' - ').collect(&:strip)
      genre_name = regex[:genre]
      {artist_name: artist_name, song_name: song_name, genre_name: genre_name}
    end
  end
end
