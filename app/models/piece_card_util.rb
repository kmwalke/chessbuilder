class PieceCardUtil < ApplicationRecord
  def self.populate
    card_data.each do |card|
      PieceCard.find_or_create_by(
        name: card[:name],
        level: card[:level],
        host_symbol: card[:host_symbol],
        guest_symbol: card[:guest_symbol]
      )
    end
  end

  def self.card_data
    [
      { name: PieceCard::PAWN, level: 0, host_symbol: '♙', guest_symbol: '♟' },
      { name: PieceCard::ROOK, level: 0, host_symbol: '♖', guest_symbol: '♜' },
      { name: PieceCard::KNIGHT, level: 0, host_symbol: '♘', guest_symbol: '♞' },
      { name: PieceCard::BISHOP, level: 0, host_symbol: '♗', guest_symbol: '♝' },
      { name: PieceCard::QUEEN, level: 0, host_symbol: '♕', guest_symbol: '♛' },
      { name: PieceCard::KING, level: 0, host_symbol: '♔', guest_symbol: '♚' }
    ]
  end
end
