class PieceCard < ApplicationRecord
  has_and_belongs_to_many :decks
  has_many :pieces

  PAWN       = 'Pawn'.freeze
  ROOK       = 'Rook'.freeze
  KNIGHT     = 'Knight'.freeze
  BISHOP     = 'Bishop'.freeze
  QUEEN      = 'Queen'.freeze
  KING       = 'King'.freeze
  GARRISON   = 'Garrison'.freeze
  BANNERET   = 'Banneret'.freeze
  ARCHBISHOP = 'Archbishop'.freeze
  EMPRESS    = 'Empress'.freeze
  EMPEROR    = 'Emperor'.freeze

  ENLISTED_RANKS = %w[Private PFC Specialist Corporal Sergeant].freeze
  OFFICER_RANKS  = %w[Lieutenant Captain Major Colonel General].freeze

  def rank_name
    return ENLISTED_RANKS[rank - 1] if name == PAWN

    OFFICER_RANKS[rank - 1]
  end

  def start_positions
    rules['start']
  end

  def start_vectors
    rules['start_vectors']
  end

  def move_vectors
    rules['move_vectors']
  end

  def attack_vectors
    rules['attack_vectors']
  end
end
