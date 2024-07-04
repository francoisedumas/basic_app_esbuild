# frozen_string_literal: true

module Users
  class Contract < ApplicationRecord
    extend Enumerize

    STATES = %i[initiated sent declined signed].freeze

    enumerize :state, in: STATES, predicates: true, default: :initiated

    belongs_to :user
    has_one_attached :document
  end
end
