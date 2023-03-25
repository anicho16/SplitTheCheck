json.extract! restaurant, :id, :name, :location, :willSplit, :wontSplit, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
