class AddIdsToSoms < ActiveRecord::Migration
  def change
    add_column :soms, :prov_id, :integer
  end
end
