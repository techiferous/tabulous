class CreateGalaxiesEllipticalGalaxies < ActiveRecord::Migration[5.0]
  def change
    create_table :galaxies_elliptical_galaxies do |t|
      t.string :name

      t.timestamps
    end
  end
end
