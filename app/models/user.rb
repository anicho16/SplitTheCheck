class User < ApplicationRecord
  validates :username, presence: true
  validates :password, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_many :votes

  def has_voted?(restaurant)
    votes.exists?(restaurant_id: restaurant.id)
  end
end
