class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :location, presence: true

  before_save :set_defaults

  has_many :votes
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_many :comments

  def set_defaults
    self.willSplit ||= 1
    self.wontSplit ||= 1
  end

  def increment_will_split
    self.willSplit += 1
    save
  end
  def increment_wont_split
    self.wontSplit += 1
    save
  end

  def toggle_favorite_for(user)
    if favorited_by.include?(user)
      favorites.find_by(user: user).destroy
    else
      favorites.create(user: user)
    end
  end
end
