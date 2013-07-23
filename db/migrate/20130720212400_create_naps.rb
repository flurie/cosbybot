class CreateNaps < ActiveRecord::Migration
  def change
    create_table :naps do |t|
      t.string :kd
      t.integer :end
      t.string :note

      t.timestamps
    end
  end
end
