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
