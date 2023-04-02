class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :location, presence: true

  before_save :set_defaults

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
end
