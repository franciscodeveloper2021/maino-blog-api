require 'rails_helper'

RSpec.describe UserModule::UserRepository, type: :repository do
  let(:user_repo) { UserModule::UserRepository.new }

  context "with valid params" do
    let(:params) do
      {
        name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password_digest: "password123",
        password_digest_confirmation: "password123"
      }
    end

    describe "#create" do
      it "creates a new user" do
        expect { user_repo.create(params) }.to change(User, :count).by(1)
      end

      it "returns user data except password" do
        user = user_repo.create(params)

        expect(user.keys).not_to include('password_digest')
      end
    end
  end

  context "with invalid params" do

    describe "#create" do
      it "raises a Runtime error" do
        params = {
          name: "J",
          last_name: "D",
          email: "22john.com",
          password_digest: "password123",
          password_digest_confirmation: "pa"
        }

        expect { user_repo.create(params) }.to raise_error(RuntimeError)
      end
    end
  end
end
