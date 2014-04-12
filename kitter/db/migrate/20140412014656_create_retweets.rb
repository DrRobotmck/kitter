class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.references :tweet, index: true
      t.references :user, index: true
    end
  end
end
