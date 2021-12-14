RSpec.describe "Recipe", type: :system do
  describe 'ユーザーログイン後のテスト' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:recipe) { create(:recipe, user: user) }
    let!(:other_recipe) { create(:recipe, user: other_user) }
    let!(:taist) { create(:taist, recipe: recipe) }
    let!(:other_taist) { create(:taist, recipe: other_recipe) }
    let!(:recipe_comment) { create(:recipe_comment, recipe: recipe, user: user) }
    let!(:tools) { ["ハリオ", "カリタ", "メリタ"] }
    let!(:beans) { ["モカ", "キリマンジャロ", "コロンビア", "コナ", "マンデリン", "グアテマラ", "ブラジル", "ケニア"] }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    describe 'ログイン後のヘッダーテスト' do
      context 'リンクの内容を確認' do
        it "let's pourを押すと新規投稿画面に遷移する" do
          new_link = find_all('a')[1]
          new_link.click
          expect(current_path).to eq ('/recipes/new')
        end
        it "My pageを押すとユーザー詳細画面に遷移する" do
          show_link = find_all('a')[2]
          show_link.click
          expect(current_path).to eq ("/users/#{user.id}")
        end
        it "Recipesを押すとトップ画面に遷移する" do
          top_link = find_all('a')[3]
          top_link.click
          expect(current_path).to eq ('/')
        end
        it "ログアウトを押すとトップ画面に遷移する" do
          top_link = find_all('a')[4]
          top_link.click
          expect(current_path).to eq ('/')
        end
      end



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

    describe '自分のレシピ詳細画面のテスト' do
      before do
        visit recipe_path(recipe)
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq ("/recipes/#{recipe.id}")
        end
        it 'レシピの項目がすべて表示されているか' do
          expect(page).to have_content recipe.bean
          expect(page).to have_content recipe.roast_i18n
          expect(page).to have_content recipe.extraction_time_minutes
          expect(page).to have_content recipe.extraction_time_seconds
          expect(page).to have_content recipe.pre_infusion_time
          expect(page).to have_content recipe.temperature
          expect(page).to have_content recipe.grind_size_i18n
          expect(page).to have_content recipe.amount_of_beans
          expect(page).to have_content recipe.amount_of_extraction
          expect(page).to have_content recipe.introduction
          expect(page).to have_selector 'img.attachment.recipe'
        end
        it '編集リンクの確認' do
          expect(page).to have_link 'Edit', href: edit_recipe_path(recipe)
        end
         it '削除リンクの確認' do
          expect(page).to have_link 'Delete', href: recipe_path(recipe)
        end
         it 'チャートは表示されているか' do
          expect(page).to have_selector 'canvas'
        end
        it 'コメントフォームに値が入ってない' do
          expect(find_field('recipe_comment[comment]').text).to be_blank
        end
        it 'コメント送信フォームは表示されているか' do
          expect(page).to have_field 'recipe_comment[comment]'
        end
        it 'コメント送信ボタンは表示されているか' do
          expect(page).to have_button '送信する'
        end

        context 'サイドバーの確認' do
          it '自分の画像、名前、紹介文は表示されるか' do
            expect(page).to have_selector 'img.attachment.user'
            expect(page).to have_content user.name
            expect(page).to have_content user.introduction
          end
          it 'フォロー数、フォロワー数は表示されるか' do
            expect(page).to have_content user.followings.count
            expect(page).to have_content user.followers.count
          end
          it 'フォロー一覧、フォロワー一覧リンクは表示されるか' do
            expect(page).to have_link 'Follower', href: followers_user_path(user)
            expect(page).to have_link 'Follow', href: followings_user_path(user)
          end
          it '自分の詳細画面のリンクの確認' do
           link = find('#profile__user-link')
           expect(link[:href]).to eq user_path(user)
          end
          it 'お気に入り一覧リンク確認' do
            expect(page).to have_link 'お気に入り一覧', href: favorites_recipes_path
          end
          it 'ユーザー編集画面へのリンク確認' do
            expect(page).to have_link 'プロフィール編集', href: edit_user_path(user)
          end
        end

        context 'レシピ削除のテスト' do
          before do
            click_link 'Delete'
          end

          it '正しく削除される' do
            expect(Recipe.where(id: recipe.id).count).to eq 0
          end
        end

        context 'コメント機能のテスト' do


        end

      end
    end

    describe '他人のレシピ詳細画面のテスト(自分のレシピ詳細画面と共通部分は除く)' do
      before do
        visit recipe_path(other_recipe)
      end

      context '表示の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq ("/recipes/#{other_recipe.id}")
        end
        it 'Editリンクが表示されない' do
          expect(page).not_to have_link 'Edit'
        end
        it 'Deleteリンクが表示されない' do
          expect(page).not_to have_link 'Delete'
        end
        it 'Deleteリンクが表示されない' do
          expect(page).not_to have_link 'Delete'
        end
        it 'Deleteリンクが表示されない' do
          expect(page).not_to have_link 'Delete'
        end
        it 'お気に入り一覧リンクが表示されない' do
          expect(page).not_to have_link 'お気に入り一覧', href: favorites_recipes_path
        end
        it '他ユーザー編集画面へのリンクが表示されない' do
          expect(page).not_to have_link 'プロフィール編集', href: edit_user_path(other_user)
        end
        it 'プロフィール画像のURLの確認' do
          expect(page).to have_link '', href: user_path(other_user)
        end
        it '他のユーザーの名前、紹介文は表示されるか' do
          expect(page).to have_content other_user.name
          expect(page).to have_content other_user.introduction
        end
        it 'フォローボタンは表示されるか' do
           link = find('.profile__follow-btn')
           expect(link[:href]).to eq user_relationships_path(other_user)
        end
      end


    end
  end
end
