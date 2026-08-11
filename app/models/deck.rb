class Deck < ApplicationRecord
  validates :name, presence: true

  DEFAULT_NAME = 'My Deck'.freeze

  belongs_to :user

  has_and_belongs_to_many :piece_cards
end
