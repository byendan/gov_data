class ValidRoverDates < ActiveRecord::Migration
  def change
    create_table :valid_rover_dates do |t|
      t.string :rover
      t.string :camera

      t.timestamps null: false
    end
  end
end
