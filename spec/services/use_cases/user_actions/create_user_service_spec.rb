require 'rails_helper'

RSpec.describe UseCases::UserActions::CreateUserService, type: :service do
  let(:user_repository) { double("UserRepository") }

  context "when repository is injected" do
    describe "initialize" do
      it "receives the user repository as a dependency" do
        create_user_service = described_class.new(user_repository)

        expect(create_user_service.instance_variable_get(:@user_repository)).to eq(user_repository)
      end
    end
  end

  context "when repository is missing" do
    it "raises an error" do
      expect { described_class.new(nil) }.to raise_error(ArgumentError, I18n.t('errors.repository_required'))
    end
  end
end