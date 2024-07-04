# frozen_string_literal: true

class User < ApplicationRecord
  extend Enumerize

  ROLES = %i[admin default].freeze

  enumerize :role, in: ROLES, predicates: true

  has_many :customer_accounts, dependent: :destroy
  has_one :contract, class_name: "Users::Contract", dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name&.capitalize} #{last_name&.upcase}".strip.presence || email.match(/^[^@]+/).to_s.capitalize
  end
end
