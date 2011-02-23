class CreateGalaxies < ActiveRecord::Migration
  def self.up
    create_table :galaxies do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :galaxies
  end
end
