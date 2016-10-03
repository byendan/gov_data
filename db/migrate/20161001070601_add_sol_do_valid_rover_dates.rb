class AddSolDoValidRoverDates < ActiveRecord::Migration
  def change
    add_column :valid_rover_dates, :sols, :text
  end
end
