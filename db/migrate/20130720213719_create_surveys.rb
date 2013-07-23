class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :workers
      t.integer :be
      t.integer :jobs
      t.integer :max_workers
      t.integer :barren
      t.float :barren_percent
      t.integer :homes
      t.float :homes_percent
      t.integer :farms
      t.float :farms_percent
      t.integer :mills
      t.float :mills_percent
      t.integer :banks
      t.float :banks_percent
      t.integer :training_grounds
      t.float :training_grounds_percent
      t.integer :armories
      t.float :armories_percent
      t.integer :barracks
      t.float :barracks_percent
      t.integer :forts
      t.float :forts_percent
      t.integer :guard_stations
      t.float :guard_stations_percent
      t.integer :hospitals
      t.float :hospitals_percent
      t.integer :guilds
      t.float :guilds_percent
      t.integer :towers
      t.float :towers_percent
      t.integer :thieves_dens
      t.float :thieves_dens_percent
      t.integer :watch_towers
      t.float :watch_towers_percent
      t.integer :libraries
      t.float :libraries_percent
      t.integer :schools
      t.float :schools_percent
      t.integer :stables
      t.float :stables_percent
      t.integer :dungeons
      t.float :dungeons_percent

      t.timestamps
    end
  end
end
