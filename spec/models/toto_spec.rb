# frozen_string_literal: true

require "rails_helper"

RSpec.describe Toto, type: :model do
  describe "#lolo" do
    it { expect(Toto.lolo).to be_truthy }
  end
end
