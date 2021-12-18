require 'rails_helper'

RSpec.describe "Top", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }
  let!(:other_recipe) { create(:recipe, user: other_user) }
  let!(:mocha_recipe) { create(:recipe, bean: "モカ") }
  let!(:hario_recipe) { create(:recipe, tool: "ハリオ") }
  let!(:light_roast_recipe) { create(:recipe, roast: "light_roast") }
  let!(:medium_fine_recipe) { create(:recipe, grind_size: "medium_fine") }
  let!(:taist) { create(:taist, recipe: recipe) }
  let!(:other_taist) { create(:taist, recipe: other_recipe) }
  let!(:tools) { ["ハリオ", "カリタ", "メリタ"] }
  let!(:beans) { ["モカ", "キリマンジャロ", "コロンビア", "コナ", "マンデリン", "グアテマラ", "ブラジル", "ケニア"] }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

 describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示のテスト' do
      it '自分と他人のレシピ詳細ページへのリンクが表示されているか' do
        expect(page).to have_link "", href: recipe_path(recipe)
        expect(page).to have_link "", href: recipe_path(other_recipe)
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
      it 'recipeの産地と焙煎度、抽出器具、画像、投稿日が表示されているか' do
        expect(page).to have_content recipe.bean
        expect(page).to have_content recipe.tool
        expect(page).to have_content recipe.roast_i18n
        expect(page).to have_content recipe.created_at.strftime('%m/%d')
        expect(page).to have_selector 'img'
      end
      it '各ジャンル名の検索リンクは表示されているか' do
        beans.each do |bean|
          expect(page).to have_link bean
        end
        tools.each do |tool|
          expect(page).to have_link tool
        end
        Recipe.roasts_i18n.each do |roast|
          expect(page).to have_link roast[1]
        end
        Recipe.grind_sizes_i18n.each do |grind_size|
          expect(page).to have_link grind_size[1]
        end
        expect(page).to have_button 'Search'
      end
    end

    context '遷移先の確認' do
      # it 'レシピ画像の遷移先は詳細画面か' do
      #   recipes = Recipe.all
      #   find_all('a')[5].click
      #   expect(current_path).to eq('/recipes/' + recipes[0].id.to_s)
      # end
      it '検索後の遷移先は検索画面か' do
        fill_in 'keyword', with: 'モカ'
        click_on 'Search'
        expect(current_path).to eq('/recipes/search')
      end
      it '産地別、抽出器具別検索後の遷移先は検索画面か' do
        def janre_search(variables)
          variables.each do |var|
            link = find('a', text: var)
            link.click
            expect(current_path).to eq('/recipes/search')
          end
        end

        janre_search(beans)
        janre_search(tools)
      end

      it '挽目、焙煎度別検索の遷移先は検索結果外面か' do
        link_num = 12
        13.times do |link_num|
          link = all('.recipe-contents__search-link')[link_num]
          link.click
          expect(current_path).to eq('/recipes/search')
          link_num += 1
        end
      end
    end

    context '産地別検索のテスト' do
      before do
        click_link 'モカ'
      end

      it '検索ワードのレシピのみ表示される' do
        expect(all('.recipe-contents__items').count).to eq 1
      end
    end

    context '器具別別検索のテスト' do
      before do
        click_link 'ハリオ'
      end

      it '検索ワードのレシピのみ表示される' do
        expect(all('.recipe-contents__items').count).to eq 1
      end
    end

    context '焙煎度別検索のテスト' do
      before do
        click_link 'ライトロースト'
      end

      it '検索ワードのレシピのみ表示される' do
        expect(all('.recipe-contents__items').count).to eq 1
      end
    end

    context '挽目別検索のテスト' do
      before do
        click_link '細挽き'
      end

      it '検索ワードのレシピのみ表示される' do
        expect(all('.recipe-contents__items').count).to eq 1
      end
    end
  end
end