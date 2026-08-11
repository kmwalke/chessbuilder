class User < ApplicationRecord
  has_secure_password
  after_create :create_deck

  validates :email, presence: true, uniqueness: true
  validates :level, presence: true
  validates :name, presence: true
  validates :role, presence: true

  ADMIN = 'Admin'.freeze
  USER  = 'User'.freeze

  has_one :deck, dependent: :destroy

  private

  def create_deck
    Deck.find_or_create_by(
      user: self,
      name: Deck::DEFAULT_NAME
    )
  end
end
