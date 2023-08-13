class AddUserToEvaluates < ActiveRecord::Migration[6.0]
  
  def up
    add_reference :evaluates, :user, null: false, foreign_key: true
  end

  def down
    remove_reference :evaluates, :user, null: false, foreign_key: true
  end
end
