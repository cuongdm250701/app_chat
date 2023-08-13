class CreateEvaluates < ActiveRecord::Migration[6.0]
  def up
    create_table :evaluates do |t|
      t.string :content
      t.integer :evaluate_id
      t.string :evaluate_type

      t.timestamps
    end
  end

  def down
    drop_table :evaluates
  end
end
