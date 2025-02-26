# frozen_string_literal: true

class DefinitionListComponent < ViewComponent::Base
  renders_many :entries, DefinitionItemComponent
end
