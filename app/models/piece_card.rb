class PieceCard < ApplicationRecord
  has_and_belongs_to_many :decks

  PAWN   = 'Pawn'.freeze
  ROOK   = 'Rook'.freeze
  KNIGHT = 'Knight'.freeze
  BISHOP = 'Bishop'.freeze
  QUEEN  = 'Queen'.freeze
  KING   = 'King'.freeze

  def self.populate
    PieceCard.find_or_create_by(
      [
        {
          name: PieceCard::PAWN
        },
        {
          name: PieceCard::ROOK
        },
        {
          name: PieceCard::KNIGHT
        },
        {
          name: PieceCard::BISHOP
        },
        {
          name: PieceCard::QUEEN
        },
        {
          name: PieceCard::KING
        }
      ]
    )
  end
end
