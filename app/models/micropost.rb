class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140}
  
  belongs_to :original, class_name: "Micropost"
  has_many :retweets, class_name: "Micropost", foreign_key: "original_id"
  
  paginates_per 5
end
