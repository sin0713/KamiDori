FactoryBot.define do
  factory :recipe_comment do
    # アソシエーションを定義
    association :recipe
    association :user
    comment { Faker::Lorem.characters(number: 10) }
  end
end
