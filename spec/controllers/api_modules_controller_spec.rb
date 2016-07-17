require 'rails_helper'

RSpec.describe ApiModulesController, type: :controller do
  describe "api module crud methods" do
    it "creates new module" do
      post :create, api_module: FactoryGirl.attributes_for(:api_module)
      expect(ApiModule.count).to eq(1)
    end

  end
end
