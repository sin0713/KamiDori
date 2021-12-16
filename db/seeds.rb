# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  15.times do |n|
      User.create!(
        email: "coffee#{n + 1}@test.com",
        password: "111111",
        name: "さとし#{n + 1}",
        introduction: "hello world"
      )
  end

  Recipe.create!([
  {
    user_id: 1,
    roast: 3,
    bean: "ケニア",
    tool: "ハリオv60",
    extraction_time_minutes:  2,
    extraction_time_seconds:  22,
    pre_infusion_time:  15,
    temperature:  88,
    grind_size:  3,
    amount_of_beans:  25,
    amount_of_extraction:  300,
    introduction: "フルーティな香りが際立ちます",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
  },
  {
    user_id: 2,
    roast: 5,
    bean: "新橋ブレンド",
    tool: "ハリオv60",
    extraction_time_minutes: 2,
    extraction_time_seconds: 40,
    pre_infusion_time: 15,
    temperature: 93,
    grind_size: 3,
    amount_of_beans: 36,
    amount_of_extraction: 350,
    introduction: "谷中珈琲さんのブレンド豆を使いました",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
  },
  {
    user_id: 3,
    roast: 5,
    bean: "エクアドル",
    tool: "カリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "谷中珈琲さんのブレンド豆を使いました",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
  },
  {
    user_id: 4,
    roast: 5,
    bean: "キリマンジャロ",
    tool: "メリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "谷中珈琲さんのブレンド豆を使いました",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
  },
  {
    user_id: 5,
    roast: 5,
    bean: "モカ",
    tool: "カリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "谷中珈琲さんのブレンド豆を使いました",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
  },
  {
    user_id: 6,
    roast: 5,
    bean: "コロンビア",
    tool: "カリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "谷中珈琲さんのブレンド豆を使いました",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
  },
  {
    user_id: 7,
    roast: 5,
    bean: "モカ",
    tool: "カリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "谷中珈琲さんのブレンド豆を使いました",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
  },
  {
    user_id: 8,
    roast: 5,
    bean: "マンデリン",
    tool: "カリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "谷中珈琲さんのブレンド豆を使いました",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
  },
  {
    user_id: 9,
    roast: 5,
    bean: "コナ",
    tool: "カリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "谷中珈琲さんのブレンド豆を使いました",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")

  },
  {
    user_id: 10,
    roast: 5,
    bean: "モカ",
    tool: "カリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "谷中珈琲さんのブレンド豆を使いました",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
  }
])

  10.times do |n|
    Taist.create!(
      recipe_id: n + 1,
      sour: 3,
      bitter: 3,
      rich: 3,
      sweet: 3,
      flavor: 3
      )
  end
  
  20.times do 
   Recipe.create!(
    user_id: 1,
    roast: 3,
    bean: "ケニア",
    tool: "ハリオv60",
    extraction_time_minutes:  2,
    extraction_time_seconds:  22,
    pre_infusion_time:  15,
    temperature:  88,
    grind_size:  3,
    amount_of_beans:  25,
    amount_of_extraction:  300,
    introduction: "フルーティな香りが際立ちます",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
    )
  end
  
  20.times do |n|
    Taist.create!(
      recipe_id: n + 10,
      sour: 3,
      bitter: 3,
      rich: 3,
      sweet: 3,
      flavor: 3
      )
  end



