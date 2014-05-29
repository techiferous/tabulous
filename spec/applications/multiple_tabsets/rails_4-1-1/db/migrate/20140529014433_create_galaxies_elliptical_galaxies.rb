class CreateGalaxiesEllipticalGalaxies < ActiveRecord::Migration
  def change
    create_table :galaxies_elliptical_galaxies do |t|
      t.string :name

      t.timestamps
    end
  end
end
