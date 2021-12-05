class Recipe < ApplicationRecord
  has_one :taist, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  belongs_to :user
end
