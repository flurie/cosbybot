class CreateOnlines < ActiveRecord::Migration
  def change
    create_table :onlines do |t|
      t.integer :prov_id
      t.integer :time

      t.timestamps
    end
  end
end
