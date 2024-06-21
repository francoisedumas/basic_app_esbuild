# frozen_string_literal: true

module Users
  class CustomerAccountsController < ApplicationController
    def index
      @customer_accounts = current_user.customer_accounts
    end

    def new
      @customer_account = current_user.customer_accounts.build
    end

    def create
      @customer_account = current_user.customer_accounts.build(customer_account_params)

      if @customer_account.save
        redirect_to user_customer_accounts_path(current_user), notice: "customer account added"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def customer_account_params
      params.require(:customer_account).permit(:vat_number, :name)
    end
  end
end
