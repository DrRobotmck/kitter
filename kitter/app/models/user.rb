class User < ActiveRecord::Base

  has_secure_password

  has_many :tweets, dependent: :destroy
  has_many :replies
  has_many :replies, through: :tweets
  has_many :retweets
  has_many :retweets, through: :tweets
  has_many :favorites
  has_many :favorites, through: :tweets

  has_and_belongs_to_many :followers,
    foreign_key: 'follower_id', join_table: :followers
  has_and_belongs_to_many :blocked_users,
    foreign_key: 'blocked_id', join_table: :blocked_users

  validates :username, :name, :email, :bio, :website, :verified, :location, :password, :password_confirmation, :country_id,  presence: true
  validates :profile_photo_url, :background_photo_url, presence: true, on: :create

  validates :username, uniqueness: true
  validates :username, uniqueness: {case_insensitive: true}
  validates :username, length: {maximum: 15}
  validates :username, format: {with: /\w/, message: "Usernames may only contain numbers, letters, or underscores."}

  validates :email, uniqueness: true
  validates :email, uniqueness: {message: "That email is already registered."}
  validates :email, correct_email_format: true

  validates :password, length: {minimum: 5}

  validates :country_id, numericality: {only_integer:true}
  validates :verified, inclusion: { :in => [true, false]}

end
