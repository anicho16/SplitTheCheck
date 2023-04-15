class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  #Validate that a user can only vote once for a restaurant
  validates :user_id, uniqueness: {scope: :restaurant_id, message: "has already voted for this restaurant"}
end
