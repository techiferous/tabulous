class CreatePlanetsExoplanets < ActiveRecord::Migration
  def change
    create_table :planets_exoplanets do |t|
      t.string :name

      t.timestamps
    end
  end
end
