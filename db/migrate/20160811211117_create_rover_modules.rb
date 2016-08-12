class CreateRoverModules < ActiveRecord::Migration
  def change
    create_table :rover_modules do |t|
      t.string :name
      t.string :base_query
      t.string :full_query
      t.string :rover
      t.string :camera
      t.string :date


      t.timestamps null: false
    end
  end
end
