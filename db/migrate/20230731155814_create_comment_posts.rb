class CreateCommentPosts < ActiveRecord::Migration[6.0]
  def up
    create_table :comment_posts do |t|
      t.string :content

      t.timestamps
    end
  end

  def down
    drop_table :comment_posts
  end
end
