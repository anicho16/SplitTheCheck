class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]

  # GET /votes or /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1 or /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes or /votes.json
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @user = current_user

    # Check if user has already voted for this restaurant
    if @user.has_voted?(@restaurant)
      flash[:notice] = "You have already voted for this restaurant."
      redirect_to @restaurant
    else
      # Create a new vote for the user and update the restaurant's vote count
      @vote = @user.votes.create(restaurant_id: @restaurant.id)
      if params[:vote_type] == "willSplit"
        @restaurant.increment_will_split
      elsif params[:vote_type] == "wontSplit"
        @restaurant.increment_wont_split
      end
      flash[:success] = "Vote added successfully."
      redirect_to @restaurant
    end
  end

  # PATCH/PUT /votes/1 or /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to vote_url(@vote), notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1 or /votes/1.json
  def destroy
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url, notice: "Vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:user_id, :restaurant_id)
    end
end
