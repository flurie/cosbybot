class CreateProvinceChanges < ActiveRecord::Migration
  def change
    create_table :province_changes do |t|
      t.string :time
      t.string :change
      t.string :previous
      t.string :current

      t.timestamps
    end
  end
end
