class Song < ActiveRecord::Base
  attr_accessible :name, :artist
  belongs_to :artist
end
