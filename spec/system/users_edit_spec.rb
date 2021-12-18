require 'rails_helper'
RSpec.describe "Recipe", type: :system do
  let!(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
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
end
