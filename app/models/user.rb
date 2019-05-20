class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :likes
  has_many :give_likes, through: :likes, source: :micropost
  has_many :reverses_of_like, class_name: "Like", foreign_key: "micropost_id"
  has_many :take_likes, through: :reverses_of_like, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Microposts.where(user_id: self.follwing_ids + [self.id])
  end
  
  
  def favorite(micropost)
    self.likes.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unfavorite(micropost)
    like = self.likes.find_by(micropost_id: micropost.id)
    like.destroy if like
  end
  
  def give_like?(micropost)
    self.give_likes.include?(micropost)
  end
end