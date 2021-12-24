require 'rails_helper'
RSpec.describe "Recipe", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:recipe) { create(:recipe) }
  let!(:other_recipe) { create(:recipe, user: other_user) }
  let!(:other_taist) { create(:taist, recipe: recipe) }
  let!(:other_taist) { create(:taist, recipe: other_recipe) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end


  shared_context :favorite_btn_test, js:true do
    before do
      find_all("a.favorite__link-#{other_recipe.id}")[0].click
      sleep(1)
    end

    it '正しくいいねが保存されるか' do
      expect(other_recipe.favorites.count).to eq 1
      expect(page).to have_selector "a.favorite__link-#{other_recipe.id}", text: "1"
    end
    it '正しくいいねが削除されるか' do
      find_all("a.favorite__link-#{other_recipe.id}")[0].click
      sleep(1)
      expect(other_recipe.favorites.count).to eq 0
      expect(page).to have_selector "a.favorite__link-#{other_recipe.id}", text: "0"
    end
  end

  describe 'トップ画面' do
    before do
      visit root_path
    end

    include_context :favorite_btn_test
  end

  describe 'レシピ詳細画面' do
    before do
      visit recipe_path(other_recipe)
    end

    include_context :favorite_btn_test
  end

  describe 'ユーザー詳細画面' do
    before do
      visit user_path(other_user)
    end

    include_context :favorite_btn_test
  end

  describe '新着レシピ一覧画面' do
    before do
      visit new_order_recipes_path
    end

    include_context :favorite_btn_test
  end

  describe 'レシピランキング画面' do
    before do
      Favorite.create(user_id: user.id, recipe_id: other_recipe.id)
      visit ranking_recipes_path
      find_all("a.favorite__link-#{other_recipe.id}")[0].click
      sleep(1)
    end
    include_context :favorite_btn_test
  end

  describe 'お気に入り一覧画面' do
    before do
      Favorite.create(user_id: user.id, recipe_id: recipe.id)
      visit favorites_recipes_path
      find_all("a.favorite__link-#{recipe.id}")[0].click
      sleep(1)
    end

    context :favorite_btn_test, js:true do
      before do
        find_all("a.favorite__link-#{recipe.id}")[0].click
        sleep(1)
      end

      it '正しくいいねが保存されるか' do
        expect(recipe.favorites.count).to eq 1
        expect(page).to have_selector "a.favorite__link-#{recipe.id}", text: "1"
      end
      it '正しくいいねが削除されるか' do
        find_all("a.favorite__link-#{recipe.id}")[0].click
        sleep(1)
        expect(recipe.favorites.count).to eq 0
        expect(page).to have_selector "a.favorite__link-#{recipe.id}", text: "0"
      end
    end
  end
end