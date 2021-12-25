require 'rails_helper'
RSpec.describe "Recipe", type: :system do
  let!(:user) { create(:user) }

  describe 'ログイン前のヘッダーテスト' do
    before do
      visit root_path
    end

    context 'リンクの内容を確認' do
      it "ロゴを押すとトップ画面に遷移する" do
        top_link = find_all('a')[1]
        top_link.click
        expect(current_path).to eq('/')
      end
      it "TOPを押すとトップ画面に遷移する" do
        top_link = find_all('a')[2]
        top_link.click
        expect(current_path).to eq('/')
      end
      it "ABOUTを押すとアバウト画面に遷移する" do
        about_link = find_all('a')[3]
        about_link.click
        expect(current_path).to eq("/about")
      end
      it "LOG INを押すとサインアップ画面に遷移する" do
        sign_up_link = find_all('a')[4]
        sign_up_link.click
        expect(current_path).to eq('/users/sign_up')
      end
      it "LOG OUTを押すとログイン画面に遷移する" do
        sign_in_link = find_all('a')[5]
        sign_in_link.click
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end

  describe 'ログイン後のヘッダーテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    context 'リンクの内容を確認' do
      it "let's pourを押すと新規投稿画面に遷移する" do
        new_link = find_all('a')[2]
        new_link.click
        expect(current_path).to eq('/recipes/new')
      end
      it "My pageを押すとユーザー詳細画面に遷移する" do
        show_link = find_all('a')[3]
        show_link.click
        expect(current_path).to eq("/users/#{user.id}")
      end
      it "Recipesを押すとトップ画面に遷移する" do
        top_link = find_all('a')[4]
        top_link.click
        expect(current_path).to eq('/')
      end
      it "ログアウトを押すとトップ画面に遷移する" do
        top_link = find_all('a')[5]
        top_link.click
        expect(current_path).to eq('/')
      end
    end
  end
end
