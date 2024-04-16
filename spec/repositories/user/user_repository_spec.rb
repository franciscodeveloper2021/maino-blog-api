require 'rails_helper'

RSpec.describe UserModule::UserRepository, type: :repository do
  let(:user_repo) { UserModule::UserRepository.new }
  let(:params) do
    {
      name: "John",
      last_name: "Doe",
      email: "john@example.com",
      password: "password123",
    }
  end

  context "with valid params" do

    describe "#create" do
      it "creates a new user" do
        expect { user_repo.create(params) }.to change(User, :count).by(1)
      end
    end

    describe "#update" do
      it "updates current user" do
        user = User.new(params)
        user.save

        updated_params = { name: "John Updated", password: "password_new" }
        user_repo.update(user.id, updated_params)

        user.reload

        expect(user.name).to eq("John Updated")
        expect(user.password).to eq("password_new")
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

    describe "#update" do
      before(:each) do
        @user = User.new(params)
        @user.save
      end

      it "raises a RuntimeError when user is not found" do
        updated_params = { name: "John Updated", password: "password_new" }

        expect { user_repo.update(-1, updated_params) }.to raise_error(RuntimeError)
      end

      it "raises a RuntimeError when user params are not valid" do
        updated_params = { name: "J", password: "p" }

        expect { user_repo.update(@user.id, updated_params) }.to raise_error(RuntimeError)
      end
    end
  end
end
