class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def active_menu_link
    root_path
  end
  helper_method :active_menu_link
end
