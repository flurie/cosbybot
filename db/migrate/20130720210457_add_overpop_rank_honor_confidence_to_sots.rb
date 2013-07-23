class AddOverpopRankHonorConfidenceToSots < ActiveRecord::Migration
  def change
    add_column :sots, :overpop, :boolean
    add_column :sots, :rank, :string
    add_column :sots, :honor, :integer
    add_column :sots, :confidence, :integer
  end
end
