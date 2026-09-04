FactoryBot.define do
  factory :game do
    host factory: :user
    guest factory: :user
    current_player { host }
  end
end
