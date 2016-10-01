class CreateApodModules < ActiveRecord::Migration
  def change
    create_table :apod_modules do |t|
      t.string :name
      t.string :base_query

      t.timestamps null: false
    end
  end
end
