require 'rails_helper'


RSpec.describe 'Taistモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { taist.valid? }
    let(:taist) { build(:taist) }
    
    
    context 'sourカラムのテスト' do
      it '空白でないこと' do
        taist.sour = ""
        is_expected.to eq false
      end 
    end
    context 'bitterカラムのテスト' do
      it '空白でないこと' do
        taist.bitter = ""
        is_expected.to eq false
      end 
    end
    context 'sweetカラムのテスト' do
      it '空白でないこと' do
        taist.sweet = ""
        is_expected.to eq false
      end 
    end
    context 'flavorカラムのテスト' do
      it '空白でないこと' do
        taist.flavor = ""
        is_expected.to eq false
      end 
    end
    context 'richカラムのテスト' do
      it '空白でないこと' do
        taist.rich = ""
        is_expected.to eq false
      end 
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:1となっている' do
        expect(Taist.reflect_on_association(:recipe).macro).to eq :belongs_to
      end
    end 
  end 
end