FactoryBot.define do
  factory :taist do
    # アソシエーションを定義
    association :recipe
    sour { 2 }
    bitter { 2 }
    sweet { 2 }
    flavor { 2 }
    rich { 2 }
  end
end