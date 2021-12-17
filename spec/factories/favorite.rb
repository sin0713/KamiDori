FactoryBot.define do
  factory :favorite do
    # アソシエーションを定義
    association :recipe
    association :user
  end
end
