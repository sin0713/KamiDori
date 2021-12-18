require 'rails_helper'
RSpec.describe "before_sign_in", type: :system do
  describe 'ログイン画面のテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it 'emailフォームが表示されてるか' do
        expect(page).to have_field 'user[email]', with: ""
      end
      it 'パスワードフォームが表示されてるか' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示されてるか' do
        expect(page).to have_button 'Log in'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end

      it 'ログイン後のリダイレクト先が正しいか' do
        expect(current_path).to eq root_path
      end
      it '「ログインしました」が表示される' do
        expect(page).to have_content 'ログインしました'
      end
    end
  end
end 