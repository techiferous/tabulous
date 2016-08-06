class CreatePlanetsExoplanets < ActiveRecord::Migration[5.0]
  def change
    create_table :planets_exoplanets do |t|
      t.string :name

      t.timestamps
    end
  end
end
