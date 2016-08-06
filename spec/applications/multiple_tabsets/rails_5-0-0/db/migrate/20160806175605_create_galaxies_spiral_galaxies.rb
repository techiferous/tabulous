class CreateGalaxiesSpiralGalaxies < ActiveRecord::Migration[5.0]
  def change
    create_table :galaxies_spiral_galaxies do |t|
      t.string :name

      t.timestamps
    end
  end
end
