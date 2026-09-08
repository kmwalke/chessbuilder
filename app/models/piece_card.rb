class PieceCard < ApplicationRecord
  has_and_belongs_to_many :decks
  has_many :pieces

  # TODO: each kind of piece should be a class.  The rules defined in PieceCardUtil should be defined in the class
  PAWN   = 'Pawn'.freeze
  ROOK   = 'Rook'.freeze
  KNIGHT = 'Knight'.freeze
  BISHOP = 'Bishop'.freeze
  QUEEN  = 'Queen'.freeze
  KING   = 'King'.freeze
end
