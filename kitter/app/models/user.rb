class User < ActiveRecord::Base

  has_secure_password

  has_many :tweets, dependent: :destroy
  has_many :replies
  has_many :replies, through: :tweets
  has_many :retweets
  has_many :retweets, through: :tweets
  has_many :favorites
  # has_many :favorites, through: :tweets

  has_many :notifications

  has_many :favorites, foreign_key: 'user_id', class_name: 'Favorite', dependent: :destroy

  has_many :follows, foreign_key: 'user_id', :class_name=>'Follow'
  has_many :followers, through: :follows, dependent: :destroy

  has_many :blockees, foreign_key: 'user_id', :class_name=>'Blockee'
  has_many :blocked_users, through: :blockees, dependent: :destroy


  validates :username, :name, :email, :password, :password_confirmation, presence: true
  validates :bio, :website, :location, :country_id, presence: true, :if => lambda{|user| user.current_step == "additional_info"}

  validates :background_photo_url, :profile_photo_url, presence: true

  validates :username, uniqueness: true
  validates :username, uniqueness: {case_insensitive: true}
  validates :username, length: {maximum: 15}
  validates :username, format: {with: /\w/, message: "Usernames may only contain numbers, letters, or underscores."}

  validates :email, uniqueness: true
  validates :email, correct_email_format: true

  validates :password, length: {minimum: 5}

  validates :country_id, numericality: {only_integer:true}, on: :update, :if => :entering_additional_info?

  #inform model of two-step sign-up form

  #allow access to write the current_step
  attr_writer :current_step


  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  #find the current step the user is on, or default to the first
  def current_step
    @current_step || steps.first
  end

  #move to next step
  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  #go back to last step
  def previous_step
    self.current_step=steps[steps.index(current_step)-1]
  end

  #array of possible steps, based on partial names
  def steps
    %w[sign_up additional_info]
  end

  def follow(other_user)
    followers << other_user
  end

  def unfollow(other_user)
     followers.delete(other_user)
  end

  def block(other_user)
     blocked_users << other_user
  end

  def unblock(other_user)
     blocked_users.delete(other_user)
  end


  def favorite(tweet)
    self.favorites.create!(tweet: tweet)
    tweet.user.notifications.create!(tweet:tweet,poster_id: self.id, kind: 'favorited')
    tweet.update_num_of_favs
  end

  def retweet(tweet)

  end

end
