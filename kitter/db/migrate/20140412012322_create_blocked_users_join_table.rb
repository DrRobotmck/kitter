class CreateBlockedUsersJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :blocked do |t|
      # t.index [:user_id, :blocked_user_id]
      # t.index [:blocked_user_id, :user_id]
    end
  end
end
