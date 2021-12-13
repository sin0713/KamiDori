FactoryBot.define do
  factory :taist do
    # アソシエーションを定義
    association :recipe
    sour 1
    bitter 2
    sweet 3
    flavor 4
    rich 5
  end
end