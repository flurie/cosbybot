class CreateKingdoms < ActiveRecord::Migration
  def change
    create_table :kingdoms do |t|
      t.string :name
      t.string :loc
      t.integer :nw
      t.integer :land
      t.string :stance
      t.integer :wins
      t.integer :wars
      t.boolean :war

      t.timestamps
    end
  end
end
