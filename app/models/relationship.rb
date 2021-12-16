class Relationship < ApplicationRecord
  belongs_to :follow, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  
  validates :follow_id, presence: true
  validates :followed_id, presence: true
end 
