require 'rails_helper'
RSpec.describe "Recipe", type: :system do
  describe 'about画面のテスト' do
    before do
      visit about_path
    end

    it '表示の確認' do
      expect(page).to have_content 'KamiDori とは?'
    end
  end
end
