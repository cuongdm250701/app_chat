class AddPostReferenceToCommentPosts < ActiveRecord::Migration[6.0]
  def up
    add_reference :comment_posts, :post, null: false, foreign_key: true
  end

  def down
    remove_reference :comment_posts, :post, null: false, foreign_key: true
  end
end
