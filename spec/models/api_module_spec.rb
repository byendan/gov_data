require 'rails_helper'

RSpec.describe ApiModule, type: :model do
  describe "basic module functionaility" do

    it "can store a hash to the database, and retrieve it" do
      bob = ApiModule.new(name: "bob", url: "yabob.com", graph_type: "b", options: {one: 1, two: 2})
      bob.save!

      # Returned keys will be strings
      expect(bob.options).to eq({"one"=> 1, "two"=> 2})

      # Set new value to be saved
      bob.options[:three] = 3
      # Make sure it can be saved, and has the previous retrieval behavior
      expect(bob.save).to be true
      expect(bob.options).to eq({"one" => 1, "two" => 2, "three" => 3})

    end
  end
end
