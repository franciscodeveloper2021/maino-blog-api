require 'rails_helper'

RSpec.describe Post, type: :model do
  context "when invalid params" do
    let(:invalid_post) { Post.new }

    describe "validations required params" do
      it "validates title presence" do
        invalid_post.valid?
        expect(invalid_post.errors[:title]).to include(I18n.t('errors.blank'))
      end

      it "validates title length" do
        invalid_post.title = "A"
        invalid_post.valid?

        expect(invalid_post.errors[:title]).to include(I18n.t('errors.too_short', count: 2))
      end

      it "validates body presence" do
        invalid_post.valid?
        expect(invalid_post.errors[:body]).to include(I18n.t('errors.blank'))
      end

      it "validates posts without id" do
        valid_post = Post.new(title: "Example Title", body: "Example Body")

        expect(valid_post.save).to eq(false)
      end
    end
  end

  context "when valid params" do
    before do
      @user = User.new(name: "Chico", last_name: "Leite", email: "chicoleiteee@gmail.com", password: "123456")
      @user.save
    end

      it "creates post" do
      valid_post = Post.new(title: "Example Title", body: "Example Body", user_id: @user.id)

      expect(valid_post.save).to eq(true)
    end
  end
end
