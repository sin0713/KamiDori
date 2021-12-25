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

  describe '自分のユーザー詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示のテスト' do
      it 'URLは正しいか' do
        expect(current_path).to eq("/users/#{user.id}")
      end
      it '名前の表示はあるか' do
        expect(page).to have_content "#{user.name}'s recipe book"
      end
      it '自分の投稿が正しく表示されているか' do
        @count = user.recipes.count
        expect(all('.user-show__recipe-wrapper').count).to eq @count
      end
      it 'レシピのチャートが正しく表示されているか' do
        expect(page).to have_selector 'canvas'
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
      end
      it 'レシピのタイトルは表示されるか' do
        expect(page).to have_content 'Details'
      end
      it 'チャートのリンク先は正しいか' do
        link = find('.user-show__recipe-path')
        expect(link[:href]).to eq recipe_path(recipe)
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