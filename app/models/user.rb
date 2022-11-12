class User < ApplicationRecord
  has_many :posts

  validates :email, :name, :auth_token, presence: true
  
end
