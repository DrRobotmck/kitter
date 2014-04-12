require 'embedly'
require 'json'
require 'pry'

class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :retweets, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_and_belongs_to_many :hashtags

  validates :content, :user_id, :num_of_favs, :num_of_retweets, presence: true

  def load_media(url)
  embedly_api=Embedly::API.new
  obj = embedly_api.oembed url: "#{url}"
  puts obj[0].marshal_dump
  json_obj = JSON.pretty_generate(obj[0].marshal_dump)
  puts json_obj
  end
  binding.pry

end
