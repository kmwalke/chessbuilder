class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :level, presence: true
  validates :name, presence: true
  validates :role, presence: true

  ADMIN = 'Admin'.freeze
  USER  = 'User'.freeze
end
