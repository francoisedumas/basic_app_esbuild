# frozen_string_literal: true

require "rails_helper"

RSpec.describe DefinitionListComponent, type: :component do
  it "renders a definition list with entries" do
    result = render_inline(described_class.new) do |component|
      component.with_entry(term: "term 1", description: "description 1")
      component.with_entry(term: "term 1", description: "description 1")
    end

    expect(result.css("dl").count).to eq(1)
    expect(result.css("dt").count).to eq(2)

    expect(result.css("dt").first.to_html).to include("term 1")
    expect(result.css("dd").first.to_html).to include("description 1")
  end
end
