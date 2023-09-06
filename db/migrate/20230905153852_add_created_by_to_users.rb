class AddCreatedByToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :created_by, :integer
  end

  def down
    remove_column :users, created_by
  end
end
