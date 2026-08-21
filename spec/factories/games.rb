FactoryBot.define do
  factory :game do
    host factory: :user
    guest factory: :user
    current_player factory: :user
  end
end
