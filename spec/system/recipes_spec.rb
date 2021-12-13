RSpec.describe "Recipe", type: :system do
  describe 'トップ画面(root_path)のテスト' do
    let!(:user) { create(:user) }
    let!(:recipe) { create(:recipe, user: user) }
    let!(:taist) { create(:taist, recipe: recipe) }
    let!(:tools) { ["ハリオ", "カリタ", "メリタ",] }
    let!(:beans) { ["モカ", "キリマンジャロ", "コロンビア", "コナ", "マンデリン", "グアテマラ", "ブラジル", "ケニア"] }

    before do
      visit root_path
    end

    context '表示の確認' do
      it 'トップ画面(root_path)に詳細ページへのリンクが表示されているか' do
        expect(page).to have_link "", href: recipe_path(recipe)
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
        beans = ["モカ", "キリマンジャロ", "コロンビア", "コナ", "マンデリン", "グアテマラ", "ブラジル", "ケニア"]
        tools = ["ハリオ", "カリタ", "メリタ",]

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
      it 'レシピ画像の遷移先は詳細画面か' do
        recipes = Recipe.all
        find_all('a')[5].click
        expect(current_path).to eq('/recipes/' + recipes[0].id.to_s)
      end

      it '検索後の遷移先は検索画面か' do
        fill_in 'keyword', with: 'モカ'
        click_on 'Search'
        expect(current_path).to eq('/recipes/search')
      end

      it 'ジャンル検索後の遷移先は検索画面か' do
        def janre_search(variables)
          variables.each do |var|
            link = find('a', text: var)
            link.click
            expect(current_path).to eq('/recipes/search')
          end
        end

        janre_search(beans)
        janre_search(tools)

        i = 12
        13.times do |i|
          link = all('.recipe-contents__search-link')[i]
          link.click
          expect(current_path).to eq('/recipes/search')
          i += 1
        end

      end
    end
  end
end