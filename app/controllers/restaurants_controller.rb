class RestaurantsController < ApplicationController
  def index
    @restaurants = ApiFetcher.new(
      base_url,
      email,
      token
    ).get
  end

  def show
    @url = base_url + "/#{params[:id]}"
    @restaurant = ApiFetcher.new(
      @url,
      email,
      token
    ).get
  end

  def new
  end

  def create
    fetcher = ApiFetcher.new(
      base_url,
      email,
      token
    )

    @restaurant = fetcher.post(
      {
        "restaurant":
          {
            "name": params[:name],
            "address": params[:address],
            "category": params[:category]
          }
      }
    )

    if @restaurant["errors"].nil?
      redirect_to restaurant_path(@restaurant["id"])
    else
      @errors = @restaurant["errors"]
      render :new, status: :unprocessable_entity
    end
  end

  private

  def base_url
    "https://the-fork.api.lewagon.com/api/v1/restaurants"
  end

  def email
    "francois.devtech@gmail.com"
  end

  def token
    Rails.application.credentials.restaurant_api_key
  end
end
