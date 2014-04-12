class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  validates :content, :tweet_id, :user_id, presence: true
end
