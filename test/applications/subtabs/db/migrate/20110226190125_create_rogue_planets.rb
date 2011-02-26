class CreateRoguePlanets < ActiveRecord::Migration
  def self.up
    create_table :rogue_planets do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :rogue_planets
  end
end
