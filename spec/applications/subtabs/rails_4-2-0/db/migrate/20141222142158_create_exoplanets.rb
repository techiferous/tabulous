class CreateExoplanets < ActiveRecord::Migration
  def change
    create_table :exoplanets do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
