class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, foreign_key: :follow_id
  has_many :followings, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :followed_id
  has_many :followers, through: :reverse_of_relationships, source: :follow

  validates :name, presence: true, length: { in: 2..20 }
  validates :email, presence: true
  validates :introduction, length: { maximum: 50 }

  attachment :image

  def is_followed_by?(user)
    reverse_of_relationships.find_by(follow_id: user.id).present?
  end
end
