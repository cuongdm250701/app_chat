class CreatePosts < ActiveRecord::Migration[6.0]
  def up
    create_table :posts do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
