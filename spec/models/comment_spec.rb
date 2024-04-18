require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "when invalid params" do

    describe "validations required params" do
      it "does not create comment" do
        invalid_comment = Comment.new(body: "Example Comment", post_id: nil, user_id: nil)

        expect(invalid_comment).to_not eq(true)
      end
    end
  end

  context "when valid params" do

    before do
      @user = User.new(name: "Chico", last_name: "Leite", email: "chicoleiteee@gmail.com", password: "123456")
      @user.save
      @post = Post.new(title: "Example Title", body: "Example Body", user_id: @user.id)
      @post.save
    end

    it "creates comment" do
      valid_comment = Comment.new(body: "Example Comment", post_id: @post.id, user_id: @user.id)

      expect(valid_comment.save).to eq(true)
    end
  end
end
