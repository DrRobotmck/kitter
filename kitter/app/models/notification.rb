class Notification < ActiveRecord::Base
  belongs_to :tweet, foreign_key: 'tweet_id', class_name: 'Tweet'
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  belongs_to :user, foreign_key: 'poster_id', class_name: 'User'
end
