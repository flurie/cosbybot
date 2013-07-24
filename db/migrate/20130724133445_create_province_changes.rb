class CreateProvinceChanges < ActiveRecord::Migration
  def change
    create_table :province_changes do |t|
      t.integer :prov_id
      t.string :change
      t.string :previous
      t.string :current

      t.timestamps
    end
  end
end
