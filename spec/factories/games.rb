FactoryBot.define do
  factory :game do
    host factory: :user
    guest factory: :user
  end
end
