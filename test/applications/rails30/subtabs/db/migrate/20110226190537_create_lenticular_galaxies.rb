class CreateLenticularGalaxies < ActiveRecord::Migration
  def self.up
    create_table :lenticular_galaxies do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :lenticular_galaxies
  end
end
