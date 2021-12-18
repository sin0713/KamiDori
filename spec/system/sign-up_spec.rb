require 'rails_helper'
RSpec.describe "before_sign_in", type: :system do

  describe '新規登録画面のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it 'nameフォームが表示されてるか' do
        expect(page).to have_field 'user[name]', with: ""
      end
      it 'emailフォームが表示されてるか' do
        expect(page).to have_field 'user[email]', with: ""
      end
      it 'パスワードフォームが表示されてるか' do
        expect(page).to have_field 'user[password]'
      end
      it 'パスワードフォーム(確認用)が表示されてるか' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '新規登録ボタンが表示されてるか' do
        expect(page).to have_button 'Sign Up'
      end
    end

    context '新規登録のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 111111
        fill_in 'user[password_confirmation]', with: 111111
        click_button 'Sign Up'
      end

      it 'サインアップ後のリダイレクト先が正しいか' do
        expect(current_path).to eq root_path
      end
      it '「アカウント登録が完了しました」が表示される' do
        expect(page).to have_content 'アカウント登録が完了しました'
      end
    end
  end
end 