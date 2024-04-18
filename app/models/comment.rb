class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, length: { maximum: 200 }
end
