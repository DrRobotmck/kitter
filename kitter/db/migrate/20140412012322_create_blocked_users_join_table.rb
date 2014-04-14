class CreateBlockedUsersJoinTable < ActiveRecord::Migration
  def change
    create_table 'blockees', id: false,force:true do |t|
      t.references :user
      t.references :blocked_user
    end
  end
end
