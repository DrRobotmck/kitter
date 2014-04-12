require 'spec_helper'

describe User do

  it{should have_secure_password}
  it{should validate_presence_of :name}
  it{should validate_presence_of :username}
  it{should validate_presence_of :email}
  it{should validate_presence_of :background_photo_url}
  it{should validate_presence_of :profile_photo_url}
  it{should validate_presence_of :bio}
  it{should validate_presence_of :website}
  it{should validate_presence_of :verified}
  it{should validate_presence_of :location}
  it{should validate_presence_of :password}
  it{should validate_presence_of :password_confirmation}
  it{should validate_presence_of :country_id}

  it{should have_many :tweets}
  it{should have_and_belong_to_many :followers}
  it{should have_and_belong_to_many :blocked_users}
  it{should have_many :replies}
  it{should have_many :retweets}
  it{should have_many :favorites}
  it{should have_many(:retweets).through(:tweets)}
  it{should have_many(:replies).through(:tweets)}
  it{should have_many(:favorites).through(:tweets)}
end
