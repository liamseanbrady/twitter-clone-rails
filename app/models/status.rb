class Status < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :mentions

  validates :body, presence: true, length: {minimum: 5}

  default_scope { order('created_at DESC') }

  after_save :extract_mentions

  def extract_mentions
    mentions = self.body.scan(/(?<=@)[A-Za-z0-9]+/) 
    mentions.each do |mention|
      Mention.create(user: User.find_by(username: mention), status: self) if User.find_by(username: mention)
    end
  end
end