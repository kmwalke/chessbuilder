class PieceCardUtil < ApplicationRecord
  def self.populate
    card_data.each do |card|
      PieceCard.find_or_create_by(
        name: card[:name],
        level: card[:level],
        host_symbol: card[:host_symbol],
        guest_symbol: card[:guest_symbol],
        rules: card[:rules]
      )
    end
  end

  def self.card_data
    [
      {
        name: PieceCard::PAWN, level: 0, host_symbol: '♙', guest_symbol: '♟',
        rules: {
          start: %w[a2 b2 c2 d2 e2 f2 g2 h2],
          moves: [{ x: 0, y: 1, distance: 1 }]
        }
      },
      { name: PieceCard::ROOK, level: 0, host_symbol: '♖', guest_symbol: '♜',
        rules: {
          start: %w[a1 h1],
          moves: [
            {x: 0, y:1, distance: 1000},
            {x: 1, y:0, distance: 1000},
            {x: 0, y:-1, distance: 1000},
            {x: -1, y:0, distance: 1000},
          ]
        } },
      { name: PieceCard::KNIGHT, level: 0, host_symbol: '♘', guest_symbol: '♞',
        rules: {
          start: %w[b1 g1],
          moves: []
        } },
      { name: PieceCard::BISHOP, level: 0, host_symbol: '♗', guest_symbol: '♝',
        rules: {
          start: %w[c1 f1],
          moves: []
        } },
      { name: PieceCard::QUEEN, level: 0, host_symbol: '♕', guest_symbol: '♛',
        rules: {
          start: ['d1'],
          moves: []
        } },
      { name: PieceCard::KING, level: 0, host_symbol: '♔', guest_symbol: '♚',
        rules: {
          start: ['e1'],
          moves: []
        } }
    ]
  end
end
