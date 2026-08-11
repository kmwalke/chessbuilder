FactoryBot.define do
  factory :piece_card do
    sequence(:name) { |n| "Piece_Card_#{n}" }
    level { 1 }
  end
end
