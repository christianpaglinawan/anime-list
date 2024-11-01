class Anime < ApplicationRecord
  has_many :anime_studios
  has_many :studios, through: :anime_studios
  has_many :anime_genres
  has_many :genres, through: :anime_genres



  validates :score, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

end
