class FixColumnInSom < ActiveRecord::Migration
  def change
    rename_column :soms, :soliders_1, :soldiers_1
  end
end
