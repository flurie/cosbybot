class CreateWars < ActiveRecord::Migration
  def change
    create_table :wars do |t|
      t.integer :start
      t.integer :end
      t.string :kd1
      t.string :kd2
      t.string :winner

      t.timestamps
    end
  end
end
