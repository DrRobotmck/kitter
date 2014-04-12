class CreateFavoritesTable < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :tweet, index: true
      t.references :user, index: true
    end
  end
end
