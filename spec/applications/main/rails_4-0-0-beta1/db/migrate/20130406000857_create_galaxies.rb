class CreateGalaxies < ActiveRecord::Migration
  def change
    create_table :galaxies do |t|
      t.string :name

      t.timestamps
    end
  end
end
