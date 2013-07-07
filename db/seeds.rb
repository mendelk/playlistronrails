# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require File.expand_path('../../lib/scraper', __FILE__)

data_folder = File.expand_path('../data', __FILE__)

Scraper.get_files(data_folder).each do |mp3_file|
  song_info = Scraper.extract_info mp3_file
  artist = Artist.find_or_create_by_name song_info[:artist_name]
  genre = Genre.find_or_create_by_name song_info[:genre_name]
  song = Song.find_or_create_by_name song_info[:song_name]
  song.update_attributes artist: artist, genre: genre
end
