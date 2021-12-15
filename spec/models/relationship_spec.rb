require 'rails_helper'


RSpec.describe 'Relationshipモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { relationship.valid? }
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:relationship) { user.relationships.build(followed_id: other_user.id) }

    context 'follow_idカラムのテスト' do
      it '空白でないこと' do
        relationship.follow_id = ""
        is_expected.to eq false
      end
    end
    context 'followed_idカラムのテスト' do
      it '空白でないこと' do
        relationship.followed_id = ""
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(Relationship.reflect_on_association(:follow).macro).to eq :belongs_to
      end
    end
    context 'Relationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end
