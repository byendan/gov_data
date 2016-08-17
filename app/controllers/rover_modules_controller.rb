class RoverModulesController < ApplicationController
  include GovApi

  def new
    @rover_module = RoverModule.new
  end

  def create
    @rover_module = RoverModule.new(rover_params)
    @rover_module.date = fix_date(@rover_module.date)

    if rover_request(@rover_module).class == Array
      @rover_module.save
      redirect_to @rover_module
    else
      flash[:error] = "No pictures for that Rover, Camera, Date combination"
      redirect_to new_rover_module_path
    end

  end

  def show
    @rover_module = RoverModule.find(params[:id])
    @module_data = @rover_module.return_array(make_request(@rover_module.build_query))
  end

  def edit
    @rover_modue = RoverModule.find(params[:id])
  end

  def update
    @rover_module = RoverModule.find(params[:id])
    @rover_module.update_attributes(rover_params)
    redirect_to @rover_module
  end

  def destroy
    @rover_module = RoverModule.find(params[:id])
    @rover_module.destroy
    redirect_to root_path
  end

  private

    def rover_params
      params.require(:rover_module).permit(:rover, :camera, :date)
    end

    def fix_date(initial_date)
      months = %w(January February March April May June July August September October November December)
      month = nil

      months.each do |m|
        month = m if /#{m}/ =~ initial_date
      end

      new_date = initial_date.gsub(month, (months.index(month) + 1).to_s)
      new_date = new_date.gsub(',', '')
      new_date = new_date.gsub(' ', ',')

      date_ary = new_date.split(',')

      # convert world standard format to NASA desired format
      new_date = "#{date_ary[2]}-#{date_ary[1]}-#{date_ary[0]}"

      return new_date
    end

    def rover_request(rover_module)
      return rover_module.return_array(make_request(rover_module.build_query))
    end
end
