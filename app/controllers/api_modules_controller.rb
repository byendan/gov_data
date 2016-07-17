class ApiModulesController < ApplicationController
  def show
    @api_module = ApiModule.find(params[:id])
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

    if @api_module.update_attributes(params[:api_module])
      redirect_to "show"
    else
      render :edit
    end
  end

  def destroy
    @api_module = ApiModule.find(params[:id])

    if @api_module.destroy
      redirect_to "index"
    else
      render :edit
    end
  end

  private

  def api_module_params
    params.require(:api_module).permit(:name, :url, :graph_type, :options)
  end
end
