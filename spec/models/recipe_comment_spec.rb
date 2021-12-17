require 'rails_helper'

RSpec.describe 'RecipeCommentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { recipe_comment.valid? }

    let(:recipe_comment) { build(:recipe_comment) }

    context 'recipe_idカラムのテスト' do
      it '空白でないこと' do
        recipe_comment.recipe_id = ""
        is_expected.to eq false
      end
    end

    context 'user_idカラムのテスト' do
      it '空白でないこと' do
        recipe_comment.user_id = ""
        is_expected.to eq false
      end
    end

    context 'commentカラムのテスト' do
      it '空白でないこと' do
        recipe_comment.comment = ""
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(RecipeComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Recipeモデルとの関係' do
      it 'N:1となっている' do
        expect(RecipeComment.reflect_on_association(:recipe).macro).to eq :belongs_to
      end
    end
  end
end
