# frozen_string_literal: true

class RestaurantsController < ApplicationController
  def index
    @restaurants = client(base_url).get
  end

  def show
    @url = base_url + "/#{params[:id]}"
    @restaurant = client(@url).get
  end

  def new
  end

  def create
    client = client(base_url)

    @restaurant = client.post(
      {
        restaurant:
          {
            name: params[:name],
            address: params[:address],
            category: params[:category]
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

  def destroy
    @url = base_url + "/#{params[:id]}"
    @restaurant = client(@url).delete

    flash[:notice] = if @restaurant["errors"].nil?
                       @restaurant["message"]
                     else
                       @restaurant["errors"]
                     end
    redirect_to restaurants_path
  end

  private

  def client(url)
    ApiClients::RestaurantsClient.new(
      url,
      email,
      token
    )
  end

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
