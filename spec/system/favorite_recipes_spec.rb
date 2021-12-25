require 'rails_helper'
RSpec.describe "Recipe", type: :system do
  let!(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe 'お気に入りレシピ一覧画面のテスト' do
    before do
      visit favorites_recipes_path
    end

    it 'URLが正しい' do
      expect(current_path).to eq("/recipes/favorites")
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
end
