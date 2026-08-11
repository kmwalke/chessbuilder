FactoryBot.define do
  factory :deck do
    sequence(:name) { |n| "Deck_#{n}" }
    user
  end
end
