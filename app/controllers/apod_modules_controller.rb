class ApodModulesController < ApplicationController
  include GovApi

  def new
    @apod_module = ApodModule.new
  end

  def create
    @apod_module = ApodModule.new
    @apod_module.save!
    redirect_to @apod_module
  end

  def show
    @apod_module = ApodModule.find(params[:id])
    @module_data = @apod_module.return_data(make_request(@apod_module.build_query))
  end
end
