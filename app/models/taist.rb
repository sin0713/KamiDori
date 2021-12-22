class Taist < ApplicationRecord
  belongs_to :recipe

  validates :sour, presence: true, inclusion: { in: 1..5 }
  validates :bitter, presence: true, inclusion: { in: 1..5 }
  validates :sweet, presence: true, inclusion: { in: 1..5 }
  validates :rich, presence: true, inclusion: { in: 1..5 }
  validates :flavor, presence: true, inclusion: { in: 1..5 }
end
