class Deck < ApplicationRecord
  validates :name, presence: true

  DEFAULT_NAME = 'My Deck'.freeze

  belongs_to :user

  has_and_belongs_to_many :piece_cards

  after_create :provision_deck

  private

  def provision_deck
    8.times do
      piece_cards << PieceCard.find_by(name: PieceCard::PAWN)
    end
    2.times do
      piece_cards << PieceCard.find_by(name: PieceCard::ROOK)
    end
    2.times do
      piece_cards << PieceCard.find_by(name: PieceCard::KNIGHT)
    end
    2.times do
      piece_cards << PieceCard.find_by(name: PieceCard::BISHOP)
    end
    piece_cards << PieceCard.find_by(name: PieceCard::QUEEN)
    piece_cards << PieceCard.find_by(name: PieceCard::KING)
  end
end
