FactoryBot.define do
  factory :recipe do
    bean { Faker::Coffee.origin(number:10) }
    roast 0
    tool 'ハリオ'
    extraction_time_minutes 2
    extraction_time_seconds 30
    pre_infusion_time 20
    temperature 90
    grind_size 0
    amount_of_beans 35
    amount_of_extraction 300
    introduction Faker::Lorem.characters(number: 10)
    image_id Faker::Lorem.characters(number: 10)
  end
end