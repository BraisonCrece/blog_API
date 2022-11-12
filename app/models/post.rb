class Post < ApplicationRecord
  belongs_to :user

  validates :title, :content, :published, :user_id, presence: true
end
