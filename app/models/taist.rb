class Taist < ApplicationRecord
  belongs_to :recipe
  
  validates :sour, presence: true
  validates :bitter, presence: true
  validates :sweet, presence: true
  validates :rich, presence: true
  validates :flavor, presence: true
end
