class PieceCardUtil < ApplicationRecord
  def self.populate
    card_data.each do |card|
      PieceCard.find_or_create_by(name: card[:name])
    end
  end

  def self.card_data
    [
      { name: PieceCard::PAWN, level: 0 },
      { name: PieceCard::ROOK, level: 0 },
      { name: PieceCard::KNIGHT, level: 0 },
      { name: PieceCard::BISHOP, level: 0 },
      { name: PieceCard::QUEEN, level: 0 },
      { name: PieceCard::KING, level: 0 }
    ]
  end
end
