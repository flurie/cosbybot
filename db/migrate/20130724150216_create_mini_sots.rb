class CreateMiniSots < ActiveRecord::Migration
  def change
    create_table :mini_sots do |t|
      t.string :name
      t.string :race
      t.integer :land
      t.integer :nw
      t.string :rank
      t.boolean :online
      t.boolean :monarch
      t.boolean :steward
      t.boolean :protection
      t.integer :slot
      t.string :loc
      t.integer :prov_id

      t.timestamps
    end
  end
end
