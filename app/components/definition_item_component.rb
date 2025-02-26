# frozen_string_literal: true

class DefinitionItemComponent < ViewComponent::Base
  renders_one :link

  def initialize(term:, description: nil)
    super
    @term = term
    @description = description
  end

  attr_reader :term, :description
end
