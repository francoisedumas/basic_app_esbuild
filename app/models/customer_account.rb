# frozen_string_literal: true

class CustomerAccount < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :vat_number, presence: true, valvat: true
  validates :siret, siret: true
end
