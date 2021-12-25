require 'rails_helper'
RSpec.describe "Recipe", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:other_recipe) { create(:recipe, user: other_user) }
  let!(:other_taist) { create(:taist, recipe: other_recipe) }

  before do
    Relationship.create(follow_id: user.id, followed_id: other_user.id)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  shared_context 'follow btn test', js: true do
    before do
      click_link 'Unfollow'
      sleep(3)
    end

    it '正しくUnfollowされるか' do
      expect { user.followings.count }.to change(user.followings, :count).by(0)
      expect(page).to have_selector 'a.profile__follow-btn', text: 'Follow'
    end
    it '正しくFollowされるか' do
      visit current_path
      expect do
        find('a.profile__follow-btn').click
        sleep(3)
      end.to change { user.followings.count }.by(1)
      expect(page).to have_selector 'a.profile__unfollow-btn', text: 'Unfollow'
    end
  end

  describe 'レシピ詳細画面' do
    before do
      visit recipe_path(other_recipe)
    end

    include_context 'follow btn test'
  end

  describe 'フォロー一覧画面' do
    before do
      visit followings_user_path(other_user)
    end

    include_context 'follow btn test'
  end

  describe 'フォロワー一覧画面' do
    before do
      visit followers_user_path(other_user)
    end

    include_context 'follow btn test'
  end

  describe 'ユーザー詳細画面' do
    before do
      visit user_path(other_user)
    end

    include_context 'follow btn test'
  end
end
