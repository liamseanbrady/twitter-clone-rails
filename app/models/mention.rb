class Mention < ActiveRecord::Base
  belongs_to :user
  belongs_to :status

  default_scope { order('created_at DESC') }

  def mark_viewed!
    self.update(viewed_at: Time.now)
  end
end