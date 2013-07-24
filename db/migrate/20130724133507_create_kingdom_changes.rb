class CreateKingdomChanges < ActiveRecord::Migration
  def change
    create_table :kingdom_changes do |t|
      t.string :loc
      t.string :change
      t.string :previous
      t.string :current

      t.timestamps
    end
  end
end
