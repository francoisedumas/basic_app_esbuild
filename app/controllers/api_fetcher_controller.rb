# frozen_string_literal: true

class ApiFetcherController < ApplicationController
  def show
    return if params[:url].blank?

    @response = ApiFetcher.new(params[:url]).fetch
  end
end
