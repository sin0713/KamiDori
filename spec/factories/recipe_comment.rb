FactoryBot.define do
  factory :comment do
    # アソシエーションを定義
    association :recipe
    association :user
    comment { Faker::Lorem.characters(number: 10) }
  end
end