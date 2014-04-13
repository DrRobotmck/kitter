require 'embedly'
require 'json'
# require 'pry'

class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :favorites,dependent: :destroy

  has_and_belongs_to_many :hashtags, join_table: :hashtag_history

  validates :content, :user_id, :num_of_favs, :num_of_retweets, presence: true

  def load_media(url)
  embedly_api=Embedly::API.new
  obj = embedly_api.oembed url: "#{url}"
  puts obj[0].marshal_dump
  json_obj = JSON.pretty_generate(obj[0].marshal_dump)
  puts json_obj
  end
  # binding.pry

  def scan_tweet(tweet)
    tweet=find_mentions(tweet)
    tweet=find_hashtags(tweet)
    # tweet=find_links(tweet)
    return tweet
  end

  def find_media
    self.content
  end


  def find_mentions(string)
    string.split.each do |word|
      if word.match(/@\w{1,}/)
        user=User.find_by(username: (word.delete("@")))
        if user
        string.sub!(word,"<a href='/users/#{user.id}'>#{word}</a>")
        end
      end
    end
    return string
  end

  def find_hashtags(string)
    string.split.each do |word|
      if word.match(/#\w{1,}/)
        orig_word=word
        word=word.delete("#")
        hashtag=Hashtag.find_by(content: word)
        hashtag ? hashtag.increase_num_of_times_used : Hashtag.create(content: word)
        string.sub!(orig_word,"<a href='/hashtags/#{word}'>#{orig_word}</a>")
     end
   end
     return string
  end


end
