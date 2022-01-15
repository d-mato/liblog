class User < ApplicationRecord
  has_secure_password

  has_many :loans
  has_many :library_users
end
