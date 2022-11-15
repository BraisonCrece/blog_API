class Post < ApplicationRecord
  belongs_to :user

  validates :title, :content, :user_id, presence: true
  validates :published, inclusion: { in: [true, false] }
end
