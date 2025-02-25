class HeavyTasksController < ApplicationController
  def index
  end

  def create
    HeavyTasksJob.perform_later(current_user.id)
  end
end
