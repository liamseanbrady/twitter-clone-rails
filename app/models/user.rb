class User < ActiveRecord::Base
  has_many :statuses
  has_secure_password validations: false

  validates :username, presence: true, length: {minimum: 3}, uniqueness: true
  validates :email, presence: true
  validates :password, presence: true, length: {minimum: 8}, on: :create

  def to_param
    self.username
  end
end