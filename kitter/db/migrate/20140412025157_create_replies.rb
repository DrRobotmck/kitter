class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies, id: false do |t|
      t.references :user, index: true
      t.references :tweet, index: true
      t.string :content

      t.timestamps
    end
  end
end
