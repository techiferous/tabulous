class CreateGalaxies < ActiveRecord::Migration
  def change
    create_table :galaxies do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
