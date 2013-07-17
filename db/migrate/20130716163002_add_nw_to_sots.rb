class AddNwToSots < ActiveRecord::Migration
  def change
    add_column :sots, :nw, :integer
  end
end
