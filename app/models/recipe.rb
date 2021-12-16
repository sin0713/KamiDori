class Recipe < ApplicationRecord
  has_one :taist, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :taist

  validates :roast, presence: true
  validates :bean, presence: true
  validates :tool, presence: true
  validates :extraction_time_minutes, presence: true
  validates :extraction_time_seconds, presence: true
  validates :pre_infusion_time, presence: true
  validates :temperature, presence: true
  validates :grind_size, presence: true
  validates :amount_of_extraction, presence: true
  validates :amount_of_beans, presence: true

  attachment :image

  enum roast: {light_roast: 0, cinnamon_roast: 1, medium_roast: 2, high_roast: 3, city_roast: 4, full_city_roast: 5, french_roast: 6, italian_roast: 7 }
  enum grind_size: {fine: 0, medium_fine: 1, medium: 2, medium_coarse: 3, coarse: 4}

  def self.search(keyword)
    where(["bean like? OR tool like?", "%#{keyword}%", "%#{keyword}%"])
  end
  

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
