# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    @projects = Project.includes(:user).all
  end
end
