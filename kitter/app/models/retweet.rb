class Retweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet
end



# a retweet has the poster and the tweet it belongs to
# a tweet has its own user
# in order to call all the retweets of a specific user
# find all tweets that have been retweeted
# and go through and find tweets where their user_id is equal to the users id
#
#
# Tweet.where(user_id: user.id)
#
# Retweet.where(tweet_id=)
