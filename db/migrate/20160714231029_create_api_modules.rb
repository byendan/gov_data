class CreateApiModules < ActiveRecord::Migration
  def change
    create_table :api_modules do |t|
      t.string :name
      t.string :url
      t.string :graph_type
      t.string :desired_data
      t.text :options

      t.timestamps null: false
    end
  end
end
