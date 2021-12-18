require 'rails_helper'
RSpec.describe "Recipe", type: :system do
  let!(:user) { create(:user) }
  
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  
  
  describe 'レシピ新規投稿画面のテスト(フォームの表示は編集画面のテストにて確認済み)' do
    before do
      visit new_recipe_path
    end

    context '表示の確認' do
      it 'URLが正しいか' do
        expect(current_path).to eq("/recipes/new")
      end
      it 'createボタンが表示されているか' do
        expect(page).to have_button 'Create Recipe'
      end
      it 'フォームに値が入ってない' do
        expect(find_field('recipe[bean]').text).to be_blank
        expect(find_field('recipe[tool]').text).to be_blank
        expect(find_field('recipe[extraction_time_minutes]').text).to be_blank
        expect(find_field('recipe[extraction_time_seconds]').text).to be_blank
        expect(find_field('recipe[pre_infusion_time]').text).to be_blank
        expect(find_field('recipe[temperature]').text).to be_blank
        expect(find_field('recipe[amount_of_beans]').text).to be_blank
        expect(find_field('recipe[amount_of_extraction]').text).to be_blank
        expect(find_field('recipe[introduction]').text).to be_blank
        expect(find_field('recipe[image]').text).to be_blank
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'recipe[bean]', with: Faker::Lorem.characters(number: 5)
        fill_in 'recipe[tool]', with: Faker::Lorem.characters(number: 5)
        fill_in 'recipe[extraction_time_minutes]', with: 2
        fill_in 'recipe[extraction_time_seconds]', with: 30
        fill_in 'recipe[pre_infusion_time]', with: 30
        fill_in 'recipe[temperature]', with: 90
        fill_in 'recipe[amount_of_beans]', with: 50
        fill_in 'recipe[amount_of_extraction]', with: 600
        fill_in 'recipe[introduction]', with: Faker::Lorem.characters(number: 20)
        select 'ライトロースト', from: '焙煎度'
        select '細挽き', from: '挽目'
        select 5, from: '酸味'
        select 5, from: '苦味'
        select 5, from: '甘味'
        select 5, from: '香り'
        select 5, from: 'コク'
        find('.new-recipe__user-id', visible: false).set(user.id)
        find('.new-recipe__recipe-id', visible: false).set(7)
      end

      it 'レシピが正しく保存されているか' do
        expect { click_button 'Create Recipe' }.to change { user.recipes.count }.by(1)
      end
      it 'リダイレクト先が正しいか' do
        click_button 'Create Recipe'
        expect(current_path).to eq recipe_path(Recipe.last)
        expect(page).to have_content '新しいレシピを投稿しました'
      end
    end
  end
end 