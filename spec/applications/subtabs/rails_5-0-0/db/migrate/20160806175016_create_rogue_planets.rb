class CreateRoguePlanets < ActiveRecord::Migration[5.0]
  def change
    create_table :rogue_planets do |t|
      t.string :name

      t.timestamps
    end
  end
end
