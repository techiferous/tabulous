class CreatePlanetsRoguePlanets < ActiveRecord::Migration
  def self.up
    create_table :planets_rogue_planets do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :planets_rogue_planets
  end
end
