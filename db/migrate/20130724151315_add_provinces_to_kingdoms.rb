class AddProvincesToKingdoms < ActiveRecord::Migration
  def change
    add_column :kingdoms, :provinces, :integer
  end
end
