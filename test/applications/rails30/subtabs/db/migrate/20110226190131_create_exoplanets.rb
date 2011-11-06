class CreateExoplanets < ActiveRecord::Migration
  def self.up
    create_table :exoplanets do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :exoplanets
  end
end
