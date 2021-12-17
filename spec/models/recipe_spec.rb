# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { recipe.valid? }

    let!(:user) { create(:user) }
    let!(:recipe) { create(:recipe, user_id: user.id) }

    it 'beanカラムが空欄でないこと' do
      recipe.bean = ""
      is_expected.to eq false
    end
    it 'roastカラムが空欄でないこと' do
      recipe.roast = ""
      is_expected.to eq false
    end
    it 'toolカラムが空欄でないこと' do
      recipe.tool = ""
      is_expected.to eq false
    end
    it 'extraction_time_minutesカラムが空欄でないこと' do
      recipe.extraction_time_minutes = ""
      is_expected.to eq false
    end
    it 'extraction_time_secondsカラムが空欄でないこと' do
      recipe.extraction_time_seconds = ""
      is_expected.to eq false
    end
    it 'pre_infusion_timeカラムが空欄でないこと' do
      recipe.pre_infusion_time = ""
      is_expected.to eq false
    end
    it 'temperatureカラムが空欄でないこと' do
      recipe.temperature = ""
      is_expected.to eq false
    end
    it 'grind_sizeカラムが空欄でないこと' do
      recipe.grind_size = ""
      is_expected.to eq false
    end
    it 'amount_of_extractionカラムが空欄でないこと' do
      recipe.amount_of_extraction = ""
      is_expected.to eq false
    end
    it 'amount_of_beansカラムが空欄でないこと' do
      recipe.amount_of_beans = ""
      is_expected.to eq false
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Taistモデルとの関係' do
      it '1:1となっている' do
        expect(Recipe.reflect_on_association(:taist).macro).to eq :has_one
      end
    end

    context 'RecipeCommentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:recipe_comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end
