class AddGroupReferenceToPosts < ActiveRecord::Migration[6.0]
  def up
    add_reference :posts, :group, null: false, foreign_key: true
  end

  def down
    remove_reference :posts, :group, null: false, foreign_key: true
  end
end
