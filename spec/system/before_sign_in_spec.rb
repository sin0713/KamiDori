require 'rails_helper'
RSpec.describe "before_sign_in", type: :system do
  describe 'ユーザーログイン前のテスト' do
    before do
      visit root_path
    end

    describe 'ログイン前のヘッダーテスト' do
      context 'リンクの内容を確認' do
        it "let's pourを押すと新規投稿画面に遷移する" do
          top_link = find_all('a')[1]
          top_link.click
          expect(current_path).to eq ('/')
        end
        it "My pageを押すとユーザー詳細画面に遷移する" do
          about_link = find_all('a')[2]
          about_link.click
          expect(current_path).to eq ("/about")
        end
        it "Recipesを押すとトップ画面に遷移する" do
          sign_up_link = find_all('a')[3]
          sign_up_link.click
          expect(current_path).to eq ('/users/sign_up')
        end
        it "ログアウトを押すとトップ画面に遷移する" do
          sign_in_link = find_all('a')[4]
          sign_in_link.click
          expect(current_path).to eq ('/users/sign_in')
        end
      end
    end

    describe 'about画面のテスト' do
      before do
        visit about_path
      end
      it '表示の確認' do
        expect(page).to have_content 'KamiDori とは?'
      end
    end

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
         it 'パスワードフォームが表示されてるか' do
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
end
