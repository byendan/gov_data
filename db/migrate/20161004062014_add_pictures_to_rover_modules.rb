class AddPicturesToRoverModules < ActiveRecord::Migration
  def change
    add_column :rover_modules, :pictures, :text
  end
end
