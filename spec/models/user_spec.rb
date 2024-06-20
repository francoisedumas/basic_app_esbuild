# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) do
    User.new(
      email: "test@example.com",
      password: "Azerty123!"
    )
  end

  describe "#full_name" do
    context "No first name" do
      it "return the user email" do
        expect(user.full_name).to eq("Test")
      end
    end

    context "With first name" do
      it "returns the user first name" do
        user.first_name = "Alice"
        expect(user.full_name).to eq("Alice")
      end
    end
  end
end
