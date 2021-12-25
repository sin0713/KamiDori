require 'rails_helper'
RSpec.describe "Recipe", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }
  let!(:other_recipe) { create(:recipe, user: other_user) }
  let!(:taist) { create(:taist, recipe: recipe) }
  let!(:other_taist) { create(:taist, recipe: other_recipe) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe '自分のレシピ詳細画面のテスト' do
    before do
      visit recipe_path(recipe)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq("/recipes/#{recipe.id}")
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
        expect(current_path).to eq("/recipes/#{other_recipe.id}")
      end
      it 'Editリンクが表示されない' do
        expect(page).not_to have_link 'Edit'
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

    context 'コメント機能のテスト', js: true do
      before do
        fill_in 'recipe_comment[comment]', with: "コメントテスト"
        click_button '送信する'
        visit current_path
      end

      it 'コメントが正常の投稿されること', js: true do
        expect(RecipeComment.count).to eq 1
      end
      it 'コメントテストは表示されるか' do
        expect(page).to have_content "コメントテスト"
      end
      it 'コメント投稿者の名前は表示されるか' do
        expect(page).to have_content user.name
      end
      it 'コメント投稿日は表示されるか' do
        rc = user.recipe_comments.last
        expect(page).to have_content rc.created_at.strftime('%Y/%m/%d')
      end
      it 'コメント投稿者の画像は表示されるか' do
        expect(page).to have_selector 'img.comment__user-img'
      end
      it 'コメントが正常に削除されること', js: true do
        expect do
          click_link '削除'
          visit current_path
        end.to change { RecipeComment.count }.by(-1)
      end
    end
  end
end
