class ApiModulesController < ApplicationController
  include GovApi

  def show
    @api_module = ApiModule.find(params[:id])
    desired_data = @api_module.desired_data.split(',')
    options = @api_module.options
    #options not saving, have to figure that out
    @module_data = get_data(api_respond_json(@api_module.url, options), desired_data)
  end

  def index
    @api_modules = ApiModule.all
  end

  def new
    @api_module = ApiModule.new
  end

  def create
    @api_module = ApiModule.new(api_module_params)

    if @api_module.save
      redirect_to @api_module
    else
      render :new
    end
  end

  def edit
    @api_module = ApiModule.find(params[:id])
  end

  def update
    @api_module = ApiModule.find(params[:id])

    if @api_module.update_attributes(api_module_params)
      redirect_to @api_module
    else
      render :edit
    end
  end

  def destroy
    @api_module = ApiModule.find(params[:id])

    if @api_module.destroy
      redirect_to @api_modules
    else
      render :edit
    end
  end

  private

  def api_module_params
    params.require(:api_module).permit!
  end
end
