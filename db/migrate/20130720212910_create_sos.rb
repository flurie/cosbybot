class CreateSos < ActiveRecord::Migration
  def change
    create_table :sos do |t|
      t.integer :alchemy
      t.float :alchemy_effect
      t.integer :alchemy_progress
      t.integer :tools
      t.float :tools_effect
      t.integer :tools_progress
      t.integer :housing
      t.float :housing_effect
      t.string :housing_progress_integer
      t.integer :food
      t.float :food_effect
      t.integer :food_progress
      t.integer :military
      t.float :military_effect
      t.integer :military_progress
      t.integer :crime
      t.float :crime_effect
      t.integer :crime_progress
      t.integer :channeling
      t.float :channeling_effect
      t.integer :channeling_progress

      t.timestamps
    end
  end
end
