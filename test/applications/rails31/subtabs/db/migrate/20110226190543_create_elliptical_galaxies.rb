class CreateEllipticalGalaxies < ActiveRecord::Migration
  def self.up
    create_table :elliptical_galaxies do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :elliptical_galaxies
  end
end
