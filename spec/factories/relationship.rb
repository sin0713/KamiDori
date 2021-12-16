FactoryBot.define do
  factory :relationship do
    # アソシエーションを定義
    association :user
    follow_id { FactoryBot.create(:user).id }
    followed_id { FactoryBot.create(:user).id }
  end
end