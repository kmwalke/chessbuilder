class User < ApplicationRecord
  has_secure_password

  ADMIN = 'Admin'.freeze
  USER = 'User'.freeze
end
