class CreateGalaxies < ActiveRecord::Migration[5.0]
  def change
    create_table :galaxies do |t|
      t.string :name

      t.timestamps
    end
  end
end
