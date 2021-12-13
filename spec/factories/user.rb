FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 5) }
    # 実際のemailアドレスの形を指定
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 10) }
  end
end
