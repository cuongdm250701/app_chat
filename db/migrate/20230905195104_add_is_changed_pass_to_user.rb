class AddIsChangedPassToUser < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :is_changed_pass, :boolean, default: true
  end

  def down
    remove_column :users, is_changed_pass
  end
end
