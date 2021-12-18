require 'rails_helper'
RSpec.describe "Recipe", type: :system do
  let!(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }
  let!(:taist) { create(:taist, recipe: recipe) }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
  
 describe 'レシピ編集画面のテスト' do
    before do
      visit edit_recipe_path(recipe)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/recipes/' + recipe.id.to_s + '/edit'
      end
      it '「Edit」と表示される' do
        expect(page).to have_content 'Edit'
      end
      it 'レシピテーブルのフォームがすべて表示されてる' do
        expect(page).to have_field 'recipe[bean]', with: recipe.bean
        expect(page).to have_field 'recipe[roast]', with: recipe.roast
        expect(page).to have_field 'recipe[extraction_time_minutes]', with: recipe.extraction_time_minutes
        expect(page).to have_field 'recipe[extraction_time_seconds]', with: recipe.extraction_time_seconds
        expect(page).to have_field 'recipe[pre_infusion_time]', with: recipe.pre_infusion_time
        expect(page).to have_field 'recipe[temperature]', with: recipe.temperature
        expect(page).to have_field 'recipe[grind_size]', with: recipe.grind_size
        expect(page).to have_field 'recipe[amount_of_beans]', with: recipe.amount_of_beans
        expect(page).to have_field 'recipe[amount_of_extraction]', with: recipe.amount_of_extraction
        expect(page).to have_field 'recipe[introduction]', with: recipe.introduction
        expect(page).to have_field 'recipe[image]'
      end
      it 'テイストテーブルのフォームが表示されてるか' do
        expect(page).to have_select '酸味'
        expect(page).to have_select '苦味'
        expect(page).to have_select '甘味'
        expect(page).to have_select 'コク'
        expect(page).to have_select '香り'
      end
      it 'Updateボタンが表示されてるか' do
        expect(page).to have_button 'Update Recipe'
      end
    end

    context '編集成功のテスト' do
      before do
        @recipe_old_bean = recipe.bean
        @recipe_old_temperature = recipe.temperature
        @taist_old_sour = taist.sour
        fill_in 'recipe[bean]', with: Faker::Lorem.characters(number: 4)
        fill_in 'recipe[temperature]', with: 100
        select 5, from: '酸味'
        click_button 'Update'
      end

      it '産地が正しく更新される' do
        expect(recipe.reload.bean).not_to eq @recipe_old_bean
      end
      it '湯温が正しく更新される' do
        expect(recipe.reload.temperature).not_to eq @recipe_old_temperature
      end
      it '酸味が正しく更新される' do
        expect(taist.reload.sour).not_to eq @taist_old_sour
      end
      it 'リダイレクト先が、更新したレシピの詳細画面になっている' do
        expect(current_path).to eq recipe_path(recipe)
        expect(page).to have_content 'レシピを更新しました'
      end
    end
  end
end

