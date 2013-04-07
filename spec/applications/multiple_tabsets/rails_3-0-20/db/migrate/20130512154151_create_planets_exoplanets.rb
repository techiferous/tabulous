class CreatePlanetsExoplanets < ActiveRecord::Migration
  def self.up
    create_table :planets_exoplanets do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :planets_exoplanets
  end
end
