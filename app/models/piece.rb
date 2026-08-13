class Piece < ApplicationRecord
  belongs_to :piece_card

  delegate :name, to: :piece_card

  delegate :host_symbol, to: :piece_card

  delegate :guest_symbol, to: :piece_card

  delegate :rules, to: :piece_card
end
