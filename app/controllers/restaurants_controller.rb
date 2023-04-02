class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy increment_will_split increment_wont_split]

  # GET /restaurants or /restaurants.json
  def index
    if params[:name].present? && params[:location].present?
      @restaurants = Restaurant.where('name LIKE ? AND location LIKE ?', "%#{params[:name]}%", "%#{params[:location]}%")
    elsif params[:name].present?
      @restaurants = Restaurant.where('name LIKE ?', "%#{params[:name]}%")
    elsif params[:location].present?
      @restaurants = Restaurant.where('location LIKE ?', "%#{params[:location]}%")
    else
      @restaurants = Restaurant.all
    end
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully updated." }
        format.json { render :show, status: :ok, location: @restaurant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: "Restaurant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def increment_will_split
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.increment_will_split
    redirect_to restaurant_path(@restaurant)
  end
  def increment_wont_split
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.increment_wont_split
    redirect_to restaurant_path(@restaurant)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def restaurant_params
    params.fetch(:restaurant, {}).permit(:name, :location, :willSplit, :wontSplit, :restaurant_id)
  end

end
