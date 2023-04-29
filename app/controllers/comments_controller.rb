class CommentsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to restaurant_path(@restaurant)
    else
      render 'new'
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
