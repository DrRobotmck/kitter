class CreateFollowersJoinTable < ActiveRecord::Migration
  def change
    create_table :followers, id: false do |t|
      t.references :user
      t.integer :follower_id
    end
  end
end
