class AddIsFavoriteToFavorites < ActiveRecord::Migration[7.0]
  def change
    add_column :favorites, :is_favorite, :boolean
  end
end
