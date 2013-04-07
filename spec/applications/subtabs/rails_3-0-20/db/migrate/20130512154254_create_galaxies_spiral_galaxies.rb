class CreateGalaxiesSpiralGalaxies < ActiveRecord::Migration
  def self.up
    create_table :galaxies_spiral_galaxies do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :galaxies_spiral_galaxies
  end
end
