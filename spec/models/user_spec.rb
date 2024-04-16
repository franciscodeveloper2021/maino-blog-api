require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      name: "John",
      last_name: "Doe",
      email: "johndoe@gmail.com",
      password: "123456",
    )
  end

  context "when there are invalid attributes" do

    describe "validations when required attributes are not present" do
      before do
        user.assign_attributes(name: nil, last_name: nil, email: nil, password: nil)
        user.valid?
      end

      it "should invalidate user creation" do
        expect(user).not_to be_valid
      end

      it "validates presence of name" do
        expect(user.errors[:name]).to include(I18n.t('errors.blank'))
      end

      it "validates presence of last_name" do
        expect(user.errors[:last_name]).to include(I18n.t('errors.blank'))
      end

      it "validates presence of email" do
        expect(user.errors[:email]).to include(I18n.t('errors.blank'))
      end
    end

    describe "validations when attributes length do not fit in the range" do
      it "validates name minimum length" do
        user.name = "J"
        user.valid?

        expect(user.errors[:name]).to include(I18n.t('errors.too_short', count: 2))
      end

      it "validates name maximum length" do
        user.name = "J" * 51
        user.valid?

        expect(user.errors[:name]).to include(I18n.t('errors.too_long', count: 50))
      end

      it "validates last_name minimum length" do
        user.last_name = "D"
        user.valid?

        expect(user.errors[:last_name]).to include(I18n.t('errors.too_short', count: 2))
      end

      it "validates last_name maximum length" do
        user.last_name = "D" * 51
        user.valid?

        expect(user.errors[:last_name]).to include(I18n.t('errors.too_long', count: 50))
      end

      it "validates email minimum length" do
        user.email = "john@"
        user.valid?

        expect(user.errors[:email]).to include(I18n.t('errors.invalid'))
      end

      it "validates email maximum length" do
        user.email = "john@" * 254
        user.valid?

        expect(user.errors[:email]).to include(I18n.t('errors.invalid'))
      end
    end

    describe "validations when attributes pursue regex" do
      let(:invalid_emails) do
        [
          "user@example",
          "user@example..com",
          "userexample.com",
          "user@.com",
          "user@ex ample.com",
          "user@example.c",
          "user@example.com.",
          "user@example..com"
        ]
      end

      let(:users_with_wrong_emails_formats) do
        invalid_emails.map do |email|
          user.dup.tap { |u| u.email = email }
        end
      end

      it "validates email formats" do
        users_with_wrong_emails_formats.each do |user|
          user.valid?

          expect(user.errors[:email]).to include(I18n.t('errors.invalid'))
        end
      end
    end

    describe "validations when attributes are required to be unique" do
      it "validates email uniqueness case insensitive" do
        user.save

        new_user_repeated_email = user.dup
        new_user_repeated_email.email.upcase!
        new_user_repeated_email.valid?

        expect(new_user_repeated_email.errors[:email]).to include(I18n.t('errors.taken'))
      end
    end
  end

  context "when all attributes are valid" do
    it "allows user to be created" do
      expect(user.valid?).to be(true)
    end
  end
end
