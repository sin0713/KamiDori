# frozen_string_literal: true

require 'rails_helper'

describe 'モデルのテスト' do
  let!(:recipe) { create(:recipe, bean:'コナ') }

  it '有効なpostの場合は保存されるか' do
    expect(build(:recipe)).to be_valid
  end

  
end