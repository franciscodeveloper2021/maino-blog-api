require 'rails_helper'

RSpec.describe UseCases::Authentication::LoginAuthenticationService, type: :service do
  let(:user_repository) { double("UserRepository") }
  let(:valid_email) { "user@example.com" }
  let(:valid_password) { "password123" }
  let(:invalid_email) { "invalid@example.com" }
  let(:invalid_password) { "wrongpassword" }

  context "when repository is injected" do
    describe "initialize" do
      it "receives the user repository as a dependency" do
        authentication = described_class.new(user_repository)

        expect(authentication.instance_variable_get(:@user_repository)).to eq(user_repository)
      end
    end
  end

  context "when repository is missing" do
    describe "initialize" do
      it "raises an error" do
        expect { described_class.new(nil) }.to raise_error(ArgumentError, I18n.t('errors.repository_required'))
      end
    end
  end

  context "when authentication is successful" do
    describe "perform" do
      it "returns a token" do
        user = double("User", id: 1, authenticate: true)
        allow(user_repository).to receive(:find_by_attribute).with(:email, valid_email).and_return(user)
        authentication = described_class.new(user_repository)

        result = authentication.perform(valid_email, valid_password)

        expect(result).to have_key(:token)
      end
    end
  end

  context "when authentication fails" do
    describe "perform" do
      it "returns an error message" do
        allow(user_repository).to receive(:find_by_attribute).with(:email, invalid_email).and_return(nil)
        authentication = described_class.new(user_repository)

        result = authentication.perform(invalid_email, invalid_password)

        expect(result).to have_key(:error)
      end
    end
  end
end