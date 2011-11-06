class CreatePlanets < ActiveRecord::Migration
  def self.up
    create_table :planets do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :planets
  end
end
