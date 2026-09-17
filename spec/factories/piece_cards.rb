FactoryBot.define do
  factory :piece_card do
    sequence(:name) { |n| "Piece_Card_#{n}" }
    level { 1 }
    host_symbol { 'h' }
    guest_symbol { 'g' }
    rules do
      {
        start: %w[a1 h1],
        move_vectors: [{ x: 0, y: 1, distance: 1 }],
        start_vectors: [{ x: 0, y: 2, distance: 1 }],
        attack_vectors: [{ x: 1, y: 1, distance: 1 }, { x: -1, y: 1, distance: 1 }]
      }
    end
  end
end
