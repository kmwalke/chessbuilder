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

  has_many :host_games, inverse_of: :host, class_name: 'Game'
  has_many :guest_games, inverse_of: :guest, class_name: 'Game'

  private

  def create_deck
    Deck.find_or_create_by(
      user: self,
      name: Deck::DEFAULT_NAME
    )
  end
end
