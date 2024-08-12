# frozen_string_literal: true

class ApiFetcherController < ApplicationController
  def show
    return if params[:url].blank?

    @response = ApiClients::Base.new(
      params[:url]
    ).get
  end
end
