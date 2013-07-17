class CreateSots < ActiveRecord::Migration
  def change
    create_table :sots do |t|
      t.string :name
      t.string :loc
      t.string :utodate
      t.string :race
      t.integer :soldiers
      t.string :pers
      t.integer :ospecs
      t.integer :land
      t.integer :dspecs
      t.integer :peasants
      t.integer :elites
      t.integer :be
      t.integer :thieves
      t.integer :stealth
      t.integer :money
      t.integer :wizards
      t.integer :mana
      t.integer :food
      t.integer :horses
      t.integer :runes
      t.integer :prisoners
      t.integer :tb
      t.integer :off
      t.integer :def
      t.boolean :war
      t.string :dragon
      t.boolean :plague

      t.timestamps
    end
  end
end
