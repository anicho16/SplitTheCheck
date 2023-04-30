class User < ApplicationRecord
  has_secure_password
  before_save { self.email = email.downcase }
  validates :username, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  has_many :votes
  has_many :favorites, dependent: :destroy
  has_many :favorite_restaurants, through: :favorites, source: :restaurant
  has_many :comments

  def has_voted?(restaurant)
    votes.exists?(restaurant_id: restaurant.id)
  end

  def toggle_favorite_for(restaurant)
    if favorite_restaurants.include?(restaurant)
      favorites.find_by(restaurant_id: restaurant.id).destroy
    else
      favorites.create(restaurant: restaurant, is_favorite: true)
    end
  end
end
