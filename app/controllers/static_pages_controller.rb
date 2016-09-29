class StaticPagesController < ApplicationController
  include GovApi

  def show
    # sets up nasa image of day
    @apod_module = ApodModule.last
    @module_data = @apod_module.return_data(make_request(@apod_module.build_query))
  end
end
