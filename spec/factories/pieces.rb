FactoryBot.define do
  factory :piece do
    piece_card
    game
    position { 'a1' }
  end
end
