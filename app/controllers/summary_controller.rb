class SummaryController < ApplicationController
  def index
    @restaurants = Restaurant.select('DISTINCT restaurants.name, comments.content, votes.vote_type, favorites.is_favorite')
                             .joins(:votes, comments: :user, favorites: :user)
                             .where("comments.user_id = ? OR votes.user_id = ? OR favorites.user_id = ?", current_user.id, current_user.id, current_user.id)

    @willSplitVotes = Restaurant.select('distinct restaurants.name')
                                .joins(:votes)
                                .where("votes.user_id = ? AND votes.vote_type = 'Will Split'", current_user.id)

    @wontSplitVotes = Restaurant.select('DISTINCT restaurants.name')
                                .joins(:votes)
                                .where("votes.user_id = ? AND votes.vote_type == \"Won't Split\"", current_user.id)

    @comments= Restaurant.select('Distinct restaurants.name')
                         .joins(:comments)
                         .where("comment.user_id = ? AND comments.content <> null", current_user.id)

    @favorites = Restaurant.select('DISTINCT restaurants.name')
                             .joins(:favorites)
                             .where("favorites.user_id = ? AND favorites.is_favorite == 1", current_user.id)
  end
end
