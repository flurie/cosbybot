class AddProvIdToSots < ActiveRecord::Migration
  def change
    add_column :sots, :prov_id, :integer
  end
end
