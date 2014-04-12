class CreateFollowersJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :followers do |t|
      # t.index [:user_id, :follower_id]
      # t.index [:follower_id, :user_id]
    end
  end
end
