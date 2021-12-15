require 'rails_helper'
RSpec.describe "Recipe", type: :system do
  describe 'ユーザーログイン後のテスト' do
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
        it '他人のコメント削除ボタンは表示されない' do
          expect(page).not_to have_link '削除'
        end
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
        it 'リダイレクト先が、レシピ詳細画面になっているか' do
          expect(current_path).to eq user_path(user)
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

      context 'followのテスト', js:true do
        before do
          Relationship.create(follow_id: user.id, followed_id: other_user.id)
          visit current_path
          click_link 'Unfollow'
        end

        it '正しくUnfollowされるか' do
          expect{user.followings.count}.to change(user.followings, :count).by(0)
        end
        it '正しくFollowされるか', js:true do
          visit current_path
          expect {
            find('a.profile__follow-btn').click
            sleep (3)
          }.to change{ user.followings.count }.by(1)
        end
      end

      context 'コメント機能のテスト', js:true do
        before do
          fill_in 'recipe_comment[comment]', with: "コメントテスト"
          click_button '送信する'
          visit current_path
        end

        it 'コメントが正常の投稿されること', js:true do
         expect(RecipeComment.count).to eq 1
        end
        it 'コメントテストは表示されるか' do
          expect(page).to have_content "コメントテスト"
        end
        it 'コメント投稿者の名前は表示されるか' do
          expect(page).to have_content user.name
        end
        it 'コメント登校日は表示されるか' do
          rc = user.recipe_comments.last
          expect(page).to have_content rc.created_at.strftime('%Y/%m/%d')
        end
        it 'コメント投稿者の画像は表示されるか' do
          expect(page).to have_selector 'img.comment__user-img'
        end
        it 'コメントが正常に削除されること', js:true do
          expect {
            click_link '削除'
            visit current_path
          }.to change{RecipeComment.count}.by(-1)
        end
      end

      context '良いね機能のテスト', js:true do
        before do
          find('a.favorite__link').click
          visit current_path
        end
        it '正しくいいねが保存されるか', js:true do
          expect(other_recipe.favorites.count).to eq 1
        end
        it '正しくいいねが削除されるか' do
          find('a.favorite__link').click
          visit current_path
          expect(other_recipe.favorites.count).to eq 0
        end
      end
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

    describe 'レシピ新規投稿画面のテスト(フォームの表示は編集画面のテストにて確認済み)' do
      before do
        visit new_recipe_path
      end

      context '表示の確認' do
        it 'URLが正しいか' do
          expect(current_path).to eq ("/recipes/new")
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
          expect {click_button 'Create Recipe'}.to change{user.recipes.count}.by(1)
        end
        it 'リダイレクト先が正しいか' do
          click_button 'Create Recipe'
          expect(current_path).to eq recipe_path(Recipe.last)
          expect(page).to have_content '新しいレシピを投稿しました'
        end
      end
    end

    describe 'お気に入りレシピ一覧画面のテスト' do
      before do
        visit favorites_recipes_path
      end

      it 'URLが正しい' do
        expect(current_path).to eq ("/recipes/favorites")
      end
      it 'お気に入りのレシピが表示されているか' do
        @favorite_count = user.favorites.count
        expect(all('.recipe-contents__items').count).to eq @favorite_count
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
    end
    describe 'ユーザー編集画面のテスト' do
      before do
        visit edit_user_path(user)
      end

      context '表示の確認' do
        it 'URLは正しいか' do
          expect(current_path).to eq "/users/#{user.id}/edit"
        end
        it 'Edit Profileは表示されるか' do
          expect(page).to have_content 'Edit Profile'
        end
        it 'nameフォームは表示されているか' do
          expect(page).to have_field 'user[name]', with: user.name
        end
        it 'introductionフォームは表示されているか' do
          expect(page).to have_field 'user[introduction]', with: user.introduction
        end
        it 'imageフォームは表示されているか' do
          expect(page).to have_field 'user[image]'
        end
        it 'Updateボタンが表示されるか' do
          expect(page).to have_button 'Update'
        end
      end

      context '編集成功のテスト' do
        before do
          @old_user_name = user.name
          @old_user_introduction = user.introduction
          fill_in 'user[name]', with: Faker::Lorem.characters(number: 6)
          fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 20)
          click_button 'Update'
        end

        it '投稿後のリダイレクト先は正しいか' do
          expect(current_path).to eq user_path(user)
          expect(page).to have_content 'プロフィールを更新しました'
        end
        it '名前と紹介文は更新されているか' do
          expect(user.reload.name).not_to eq @old_user_name
          expect(user.reload.introduction).not_to eq @old_user_introduction
        end
      end
    end

    describe 'ユーザー詳細画面のテスト' do
      before do
        visit user_path(user)
      end

      context '表示のテスト' do
        it 'URLは正しいか' do
          expect(current_path).to eq ("/users/#{user.id}")
        end
        it '名前の表示はあるか' do
          expect(page).to have_content "#{user.name}'s Recipes"
        end
        it '自分の投稿が正しく表示されているか' do
          @count = user.recipes.count
          expect(all('.recipe-contents__items').count).to eq @count
        end
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
    end

    describe 'フォロー一覧画面のテスト' do
      before do
        Relationship.create(follow_id: user.id, followed_id: other_user.id)
        visit followings_user_path(user)
      end
      context '表示の確認' do
        it 'URLのテスト' do
          expect(current_path).to eq ("/users/#{user.id}/followings")
        end
        it 'フォローしたユーザーの名前が表示されているか' do
          expect(page).to have_content other_user.name
        end
        it 'レシピ投稿数は表示されているか' do
          expect(page).to have_content other_user.recipes.count
        end
        it 'フォロワー数は表示されているか' do
          expect(page).to have_content other_user.followings.count
        end
        it 'フォロー数は表示されているか' do
          expect(page).to have_content other_user.followers.count
        end
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
    end

  end
end
