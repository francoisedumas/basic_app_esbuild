# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    def index
      @users = User.includes(avatar_attachment: :blob).order(:last_name, :first_name)
    end

    def new
      @breadcrumb_items = {
        "admin.users.index.title": admin_users_path
      }
      @user = User.new
    end

    def edit
      @breadcrumb_items = {
        "admin.users.index.title": admin_users_path
      }
      @user = User.find(params[:id])
    end

    def create
      User.invite!(user_params)

      redirect_to admin_users_path
    end

    def update
      @user = User.find(params[:id])
      @user.update!(user_params)

      @user.invite! if email_changed?

      redirect_to admin_users_path
    end

    private

    def email_changed?
      @user.email_before_last_save && (@user.email != @user.email_before_last_save)
    end

    def user_params
      permitted_attributes = [:email, :last_name, :first_name]
      permitted_attributes << :role if current_user.admin?
      params.require(:user).permit(permitted_attributes)
    end

    def active_menu_link
      admin_users_path
    end
  end
end
