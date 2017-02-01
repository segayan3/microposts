class User < ActiveRecord::Base
  before_save {
    self.email = self.email.downcase
  }
  
  has_many :microposts
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false } # case_sensitiveは大文字小文字の区別をするかどうか
  # validates :profile, absence: true, on: :create
  validates :profile, allow_blank: true, length: { minimum: 3, maximum: 150 }
  has_secure_password
  
  # あるuserがfollowしている人の一覧
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  # あるuserをfollowしている人の一覧
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  
  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end
  
  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  has_many :favorites, foreign_key: 'user_id', dependent: :destroy
  has_many :favorite_microposts, through: :favorites, source: :micropost
  
  def favorite(micropost)
    favorites.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unfavorite(micropost)
    favorite_micropost = favorite_microposts.find_by(micropost_id: micropost.id)
    favorite_micropost.destroy if favorite_micropost
  end
  
  def favorite?(micropost)
    favorite_microposts.include?(micropost)
  end
  
  # 自分のつぶやきとフォローしている人のつぶやきを取得
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end
