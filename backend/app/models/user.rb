class User < ApplicationRecord
  has_secure_password

  has_many :access_tokens, dependent: :destroy
end
