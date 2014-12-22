class CreatePlanetsRoguePlanets < ActiveRecord::Migration
  def change
    create_table :planets_rogue_planets do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
