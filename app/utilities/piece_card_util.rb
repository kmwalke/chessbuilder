class PieceCardUtil < ApplicationRecord
  INFINITY = 10

  def self.populate
    (1..5).each do |rank|
      card_data.each do |card|
        PieceCard.find_or_create_by(
          name: card[:name],
          level: card[:level],
          rank: rank,
          host_symbol: card[:host_symbol],
          guest_symbol: card[:guest_symbol],
          rules: card[:rules]
        )
      end
    end
  end

  def self.card_data
    [
      {
        name: PieceCard::PAWN, level: 1, host_symbol: '♙', guest_symbol: '♟',
        rules: {
          start: %w[a2 b2 c2 d2 e2 f2 g2 h2],
          move_vectors: [{ x: 0, y: 1, distance: 1 }],
          start_vectors: [{ x: 0, y: 2, distance: 1 }],
          attack_vectors: [{ x: 1, y: 1, distance: 1 }, { x: -1, y: 1, distance: 1 }]
        }
      },
      { name: PieceCard::ROOK, level: 1, host_symbol: '♖', guest_symbol: '♜',
        rules: {
          start: %w[a1 h1],
          move_vectors: [
            { x: 0, y: 1, distance: INFINITY },
            { x: 1, y: 0, distance: INFINITY },
            { x: 0, y: -1, distance: INFINITY },
            { x: -1, y: 0, distance: INFINITY }
          ],
          start_vectors: [],
          attack_vectors: []
        } },
      # TODO: Find fun unicode characters for level 2 pieces
      { name: PieceCard::GARRISON, level: 2, host_symbol: '♖', guest_symbol: '♜',
        rules: {
          start: %w[a1 h1],
          upgrades: PieceCard::ROOK,
          upgrade_cost: 50,
          special_move: 'spawns pawn on death'
        } },
      { name: PieceCard::KNIGHT, level: 1, host_symbol: '♘', guest_symbol: '♞',
        rules: {
          start: %w[b1 g1],
          move_vectors: [
            { x: 1, y: 2, distance: 1 },
            { x: -1, y: 2, distance: 1 },
            { x: 1, y: -2, distance: 1 },
            { x: -1, y: -2, distance: 1 },
            { x: 2, y: 1, distance: 1 },
            { x: -2, y: 1, distance: 1 },
            { x: 2, y: -1, distance: 1 },
            { x: -2, y: -1, distance: 1 }
          ],
          start_vectors: [],
          attack_vectors: []
        } },
      { name: PieceCard::BANNERET, level: 2, host_symbol: '♘', guest_symbol: '♞',
        rules: {
          start: %w[b1 g1],
          upgrades: PieceCard::KNIGHT,
          upgrade_cost: 50,
          special_move: '3-1 L'
        } },
      { name: PieceCard::BISHOP, level: 1, host_symbol: '♗', guest_symbol: '♝',
        rules: {
          start: %w[c1 f1],
          move_vectors: [
            { x: 1, y: 1, distance: INFINITY },
            { x: -1, y: 1, distance: INFINITY },
            { x: 1, y: -1, distance: INFINITY },
            { x: -1, y: -1, distance: INFINITY }
          ],
          start_vectors: [],
          attack_vectors: []
        } },
      { name: PieceCard::ARCHBISHOP, level: 2, host_symbol: '♗', guest_symbol: '♝',
        rules: {
          start: %w[c1 f1],
          upgrades: PieceCard::BISHOP,
          upgrade_cost: 50,
          special_move: 'orthogonal 1 distance'
        } },
      { name: PieceCard::QUEEN, level: 1, host_symbol: '♕', guest_symbol: '♛',
        rules: {
          start: ['d1'],
          move_vectors: [
            { x: 1, y: 1, distance: INFINITY },
            { x: 1, y: -1, distance: INFINITY },
            { x: -1, y: 1, distance: INFINITY },
            { x: -1, y: -1, distance: INFINITY },
            { x: 1, y: 0, distance: INFINITY },
            { x: 0, y: 1, distance: INFINITY },
            { x: -1, y: 0, distance: INFINITY },
            { x: 0, y: -1, distance: INFINITY }
          ],
          start_vectors: [],
          attack_vectors: []
        } },
      { name: PieceCard::EMPRESS, level: 2, host_symbol: '♕', guest_symbol: '♛',
        rules: {
          start: ['d1'],
          upgrades: PieceCard::QUEEN,
          upgrade_cost: 50,
          special_move: 'teleport via sacrifice of friendly piece'
        } },
      { name: PieceCard::KING, level: 1, host_symbol: '♔', guest_symbol: '♚',
        rules: {
          start: ['e1'],
          move_vectors: [
            { x: 1, y: 1, distance: 1 },
            { x: 1, y: -1, distance: 1 },
            { x: -1, y: 1, distance: 1 },
            { x: -1, y: -1, distance: 1 },
            { x: 1, y: 0, distance: 1 },
            { x: 0, y: 1, distance: 1 },
            { x: -1, y: 0, distance: 1 },
            { x: 0, y: -1, distance: 1 }
          ],
          start_vectors: [],
          attack_vectors: []
        } },
      { name: PieceCard::EMPEROR, level: 2, host_symbol: '♔', guest_symbol: '♚',
        rules: {
          start: ['e1'],
          upgrades: PieceCard::KING,
          upgrade_cost: 50,
          special_move: 'orthogonal 2 distance'
        } }
    ]
  end
end
