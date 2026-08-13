class PieceCard < ApplicationRecord
  has_and_belongs_to_many :decks
  has_many :pieces

  PAWN   = 'Pawn'.freeze
  ROOK   = 'Rook'.freeze
  KNIGHT = 'Knight'.freeze
  BISHOP = 'Bishop'.freeze
  QUEEN  = 'Queen'.freeze
  KING   = 'King'.freeze
end
