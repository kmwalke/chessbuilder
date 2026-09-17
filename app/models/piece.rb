class Piece < ApplicationRecord
  belongs_to :game
  belongs_to :piece_card

  delegate :name, to: :piece_card
  delegate :host_symbol, to: :piece_card
  delegate :guest_symbol, to: :piece_card
  delegate :start_positions, to: :piece_card
  delegate :start_vectors, to: :piece_card
  delegate :attack_vectors, to: :piece_card
  delegate :move_vectors, to: :piece_card

  scope :guest, -> { where(player: Game::GUEST) }
  scope :host, -> { where(player: Game::HOST) }

  def symbol
    return host_symbol if player == Game::HOST

    guest_symbol
  end

  def to_s
    "#{name} - #{symbol}"
  end
end
