class AddPageAndPagePictureCountToRoverModule < ActiveRecord::Migration
  def change
    add_column :rover_modules, :page_number, :integer
    add_column :rover_modules, :picture_count, :integer
  end
end
