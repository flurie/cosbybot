class CreateOps < ActiveRecord::Migration
  def change
    create_table :ops do |t|
      t.integer :source
      t.integer :target
      t.string :opname
      t.integer :magnitude
      t.boolean :success
      t.integer :thieves_sent
      t.integer :losses

      t.timestamps
    end
  end
end
