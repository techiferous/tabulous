class CreateGalaxiesSpiralGalaxies < ActiveRecord::Migration
  def change
    create_table :galaxies_spiral_galaxies do |t|
      t.string :name

      t.timestamps
    end
  end
end
