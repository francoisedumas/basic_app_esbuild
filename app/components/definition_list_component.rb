# frozen_string_literal: true

class DefinitionListComponent < ViewComponent::Base
  renders_many :entries, "DefinitionItemComponent"

  class DefinitionItemComponent < ViewComponent::Base
    renders_one :link

    def initialize(term:, description: nil)
      super
      @term = term
      @description = description
    end

    attr_reader :term, :description

    def call
      safe_join(
        [content_tag(:dt, term, class: "font-semibold text-gray-800 bg-blue-100 p-2 mb-0 mt-2"),
         content_tag(:dd,
                      safe_join([final_description, link_presence].compact),
                      class: "flex justify-between bg-blue-100 p-2 mt-0 mb-2")]
      )
    end

    private

    def final_description
      content_tag(:span, description || content, class: "text-gray-800")
    end

    def link_presence
      link if link?
    end
  end
end
