class CreateStars < ActiveRecord::Migration[5.0]
  def change
    create_table :stars do |t|
      t.string :name

      t.timestamps
    end
  end
end
