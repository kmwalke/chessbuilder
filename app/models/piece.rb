class Piece < ApplicationRecord
  # TODO: these should be in user or game, not here
  HOST  = 'Host'.freeze
  GUEST = 'Guest'.freeze

  belongs_to :game
  belongs_to :piece_card

  delegate :name, to: :piece_card

  delegate :host_symbol, to: :piece_card

  delegate :guest_symbol, to: :piece_card

  delegate :rules, to: :piece_card

  def symbol
    return host_symbol if player == HOST

    guest_symbol
  end

  def to_s
    "#{name} - #{symbol}"
  end
end
