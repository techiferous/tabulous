class CreateStars < ActiveRecord::Migration
  def self.up
    create_table :stars do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :stars
  end
end
