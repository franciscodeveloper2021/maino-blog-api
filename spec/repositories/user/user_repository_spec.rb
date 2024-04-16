require 'rails_helper'

RSpec.describe UserModule::UserRepository, type: :repository do
  let(:user_repo)  do
    UserRepository.new
  end

  describe "#create" do
    it "creates a new user with valid parameters" do
      params = {
        name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password123",
        password_confirmation: "password123"
      }

      expect { user_repo.create(params).to change(User, :count).by(1) }
    end
  end
end