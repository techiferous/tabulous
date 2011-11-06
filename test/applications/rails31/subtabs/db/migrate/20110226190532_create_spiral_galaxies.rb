class CreateSpiralGalaxies < ActiveRecord::Migration
  def self.up
    create_table :spiral_galaxies do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :spiral_galaxies
  end
end
