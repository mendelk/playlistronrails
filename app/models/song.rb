class Song < ActiveRecord::Base
  attr_accessible :name, :artist, :genre
  belongs_to :artist
  belongs_to :genre
end
