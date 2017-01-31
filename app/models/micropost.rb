class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140}
  
  belongs_to :original, class_name: "Micropost"
  has_many :retweets, class_name: "Micropost", foreign_key: "original_id"
  
  has_many :favorites, foreign_key: 'micropost_id', dependent: :destroy
  has_many :fovarite_users, through: :favorites, source: :user
  
  paginates_per 5
end
