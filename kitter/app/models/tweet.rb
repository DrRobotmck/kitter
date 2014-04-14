require 'embedly'

class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :replies, dependent: :destroy
  has_many :retweets, dependent: :destroy
  # has_many :favorites,dependent: :destroy

  has_many :favorites, foreign_key: 'tweet_id', class_name: 'Favorite',dependent: :destroy

  has_and_belongs_to_many :hashtags, join_table: :hashtag_history

  validates :content, :user_id, :num_of_favs, :num_of_retweets, presence: true

  def scan_tweet(content)
    find_links(content) && find_hashtags(content) && find_mentions(content)
  end

   def find_links(string)
    string.split.each do |word|
    string.sub!(word,self.embed_media(word)) if self.uri?(word)
    end
    return string
  end

  def uri?(string)
    parser=URI::Parser.new
    uri = parser.parse(string)
    %w( http https www. ).include?(uri.scheme)
    rescue URI::BadURIError
    false
    rescue URI::InvalidURIError
    false
  end

  def embed_media(url)
    embedly_api = Embedly::API.new :key => '1417d995b5a74c61b647102980df6107'
    obj = (embedly_api.oembed :url => url)[0]
    if obj[:type]=='video'
      obj[:html] if obj[:type]=='video'
    elsif obj[:type]=='photo'
      "<img class='tweet_display-photo' src='#{url}'>"
    else
      if obj[:title]
        url=obj[:title]
      end
      "<a href='url'>#{url}</a>"
    end
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

  def update_num_of_favs
    update(num_of_favs: self.num_of_favs+=1)
  end

  def update_num_of_retweets
    update(num_of_retweets: self.num_of_retweets+=1)
  end

  def favorite(favoriter)
    new_favorite = Favorite.create(user: favoriter,tweet: self)
    favoriter.favorites << new_favorite
    Notification.create(user:self.user,tweet:self,poster_id: favoriter.id, kind: 'favorited')
    update_num_of_favs
  end

end
