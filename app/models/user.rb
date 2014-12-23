class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :statuses
  has_many :mentions

  has_many :follower_relationships, class_name: 'Relationship', foreign_key: 'leader_id'
  has_many :followers, through: :follower_relationships, source: :follower
  
  has_many :following_relationships, class_name: 'Relationship', foreign_key: 'follower_id'
  has_many :followings, through: :following_relationships, source: :leader

  validates :username, presence: true, length: {minimum: 3}, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true, length: {minimum: 8}, on: :create

  def to_param
    self.username
  end

  def unread_mentions
    self.mentions.where(viewed_at: nil)
  end

  def num_unread_mentions
    unread_mentions.count
  end

  def mark_unread_mentions!
    self.unread_mentions.each do |mention|
      mention.mark_viewed!
    end
  end
end