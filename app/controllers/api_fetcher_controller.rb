# frozen_string_literal: true

class ApiFetcherController < ApplicationController
  def show
    return if params[:url].blank?

    @response = ApiFetcher.new(
      params[:url],
      params[:x_user_email],
      params[:x_user_token]
    ).get
  end
end
