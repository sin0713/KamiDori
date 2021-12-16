require 'rails_helper'


RSpec.describe 'Favoriteモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { favorite.valid? }
    let(:favorite) { build(:favorite) }
    
    context 'recipe_idカラムのテスト' do
      it '空白でないこと' do
        favorite.recipe_id = ""
        is_expected.to eq false
      end
    end
    context 'user_idカラムのテスト' do
      it '空白でないこと' do
        favorite.user_id = ""
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Recipeモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:recipe).macro).to eq :belongs_to
      end
    end
  end
end 