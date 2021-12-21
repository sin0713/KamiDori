# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_names = [
  "ryu",
  "sugar",
  "isshy",
  "shin",
  "satoshi",
  "takashi",
  "toru",
  "takeru",
  "takahashi",
  "tatuya",
  "mai",
  "ishikawa",
  "koiuzmi",
  "inoue",
  "kobayashi"
]

  user_names.each.with_index(1) do |user_name, i|
    User.create!(
      email: "coffee#{ i }@email.com",
      password: "111111",
      name: user_name,
      introduction: "hello"
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
    image: File.open("#{Rails.root}/app/assets/images/coffee-beans-hand.jpg")
  },
  {
    user_id: 2,
    roast: 6,
    bean: "新橋ブレンド",
    tool: "ハリオv60",
    extraction_time_minutes: 2,
    extraction_time_seconds: 40,
    pre_infusion_time: 15,
    temperature: 93,
    grind_size: 3,
    amount_of_beans: 36,
    amount_of_extraction: 350,
    introduction: "角が無く、濃厚な味わいに仕上がります",
    image: File.open("#{Rails.root}/app/assets/images/coffee-beans1.jpg")
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
    introduction: "濃いのが好きな方にお勧めです",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup-book2.jpg")
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
    introduction: "すっきりとした酸味に仕上がります",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup-pod.jpg")
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
    introduction: "KALDIさんの深煎りのモカを使いました"
  },
  {
    user_id: 6,
    roast: 5,
    bean: "コロンビア",
    tool: "メリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "お店で焙煎してもらったので香りがとても良いです",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup-glass.jpg")
  },
  {
    user_id: 7,
    roast: 4,
    bean: "モカ",
    tool: "カリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "中心に円を描くように注ぐのがポイントです"
  },
  {
    user_id: 8,
    roast: 2,
    bean: "マンデリン",
    tool: "カリタ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "乾いた大地のような香りがします"
  },
  {
    user_id: 9,
    roast: 4,
    bean: "コナ",
    tool: "コーノ",
    extraction_time_minutes: 1,
    extraction_time_seconds: 55,
    pre_infusion_time:  15,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 300,
    introduction: "コナ特有の香りをお楽しみください",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup1.jpg")

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
    introduction: "フローラルな香りを楽しめます"
  },
  {
    user_id: 11,
    roast: 3,
    bean: "コスタリカ",
    tool: "ハリオ",
    extraction_time_minutes: 2,
    extraction_time_seconds: 55,
    pre_infusion_time:  30,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 450,
    introduction: "時間をかけすぎず、３分以内に抽出しましょう",
    image: File.open("#{Rails.root}/app/assets/images/coffee-grains.jpg")
  },
  {
    user_id: 12,
    roast: 3,
    bean: "キリマンジャロ",
    tool: "ハリオ",
    extraction_time_minutes: 2,
    extraction_time_seconds: 55,
    pre_infusion_time:  30,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 450,
    introduction: "フィルターには直接お湯をかけないように"
  },
   {
    user_id: 13,
    roast: 5,
    bean: "コロンビア",
    tool: "ハリオ",
    extraction_time_minutes: 2,
    extraction_time_seconds: 55,
    pre_infusion_time:  30,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 450,
    introduction: "香ばしいナッツのような香り",
    image: File.open("#{Rails.root}/app/assets/images/coffee-cup2.jpg")
  },
   {
    user_id: 14,
    roast: 4,
    bean: "エチオピア",
    tool: "ハリオ",
    extraction_time_minutes: 2,
    extraction_time_seconds: 25,
    pre_infusion_time:  30,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 450,
    introduction: "すっきり仕上げるなら手早く抽出しましょう",
    image: File.open("#{Rails.root}/app/assets/images/coffee-beans3.jpg")
  },
   {
    user_id: 15,
    roast: 5,
    bean: "ブラジル",
    tool: "メリタ",
    extraction_time_minutes: 2,
    extraction_time_seconds: 55,
    pre_infusion_time:  30,
    temperature: 92,
    grind_size: 3,
    amount_of_beans: 25,
    amount_of_extraction: 450,
    introduction: "スタンダードな味わいに仕上がります",
    image: File.open("#{Rails.root}/app/assets/images/coffee-beans4.jpg")
  }
])

Taist.create! ([
  {
    recipe_id: 1,
    sour: 5,
    bitter: 2,
    sweet: 3,
    rich: 3,
    flavor: 4
  },
  {
    recipe_id: 2,
    sour: 2,
    bitter: 5,
    sweet: 3,
    rich: 5,
    flavor: 5
  },
  {
    recipe_id: 3,
    sour: 2,
    bitter: 5,
    sweet: 3,
    rich: 5,
    flavor: 4
  },
  {
    recipe_id: 4,
    sour: 4,
    bitter: 3,
    sweet: 4,
    rich: 2,
    flavor: 4
  },
  {
    recipe_id: 5,
    sour: 3,
    bitter: 4,
    sweet: 4,
    rich: 5,
    flavor: 4
  },
  {
    recipe_id: 6,
    sour: 3,
    bitter: 4,
    sweet: 4,
    rich: 4,
    flavor: 4
  },
  {
    recipe_id: 7,
    sour: 2,
    bitter: 5,
    sweet: 3,
    rich: 5,
    flavor: 4
  },
  {
    recipe_id: 7,
    sour: 4,
    bitter: 3,
    sweet: 5,
    rich: 3,
    flavor: 5
  },
  {
    recipe_id: 8,
    sour: 4,
    bitter: 4,
    sweet: 3,
    rich: 5,
    flavor: 4
  },
  {
    recipe_id: 9,
    sour: 4,
    bitter: 4,
    sweet: 4,
    rich: 5,
    flavor: 4
  },
  {
    recipe_id: 10,
    sour: 4,
    bitter: 4,
    sweet: 3,
    rich: 5,
    flavor: 4
  },
  {
    recipe_id: 11,
    sour: 4,
    bitter: 2,
    sweet: 4,
    rich: 3,
    flavor: 5
  },
  {
    recipe_id: 12,
    sour: 5,
    bitter: 2,
    sweet: 4,
    rich: 3,
    flavor: 4
  },
  {
    recipe_id: 13,
    sour: 5,
    bitter: 2,
    sweet: 4,
    rich: 3,
    flavor: 4
  },
  {
    recipe_id: 14,
    sour: 5,
    bitter: 2,
    sweet: 4,
    rich: 3,
    flavor: 4
  },
  {
    recipe_id: 15,
    sour: 3,
    bitter: 3,
    sweet: 3,
    rich: 3,
    flavor: 3
  }
])







