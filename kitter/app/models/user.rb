class User < ActiveRecord::Base

  has_secure_password
  has_many :tweets, dependent: :destroy
  has_and_belongs_to_many :followers,
    foreign_key: 'follower_id',dependent: :destroy
  has_and_belongs_to_many :blocked_users,
    foreign_key: 'blocked_id', dependent: :destroy
  has_many :replies
  has_many :favorites
  has_many :retweets

  validates :username, :name, :email, :bio, :website, :verified, :location, :password, :password_confirmation, :country_id,  presence: true
  validates :profile_photo_url, :background_photo_url, presence: true, on: :create
  validates :username, :email, uniqueness: true
  validates :country_id, numericality: {only_integer:true}
  validates :password, length: {minimum: 5}

end
