require 'rails_helper'

RSpec.describe UserModule::UserRepository, type: :repository do
  let(:user_repo) { UserModule::UserRepository.new }

  context "with valid params" do
    let(:params) do
      {
        name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password123",
      }
    end

    describe "#create" do
      it "creates a new user" do
        expect { user_repo.create(params) }.to change(User, :count).by(1)
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
          password: "password123"
        }

        expect { user_repo.create(params) }.to raise_error(RuntimeError)
      end
    end
  end
end
