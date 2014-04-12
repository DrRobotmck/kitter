class Hashtag < ActiveRecord::Base
  has_and_belongs_to_many :tweets

  validate :content, :num_of_times_used, presence: true
  validate_numericality_of :num_of_times_used, equal_to: 1 , on: :create
end
