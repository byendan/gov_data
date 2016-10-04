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

  def find_dates
    @rover = params[:rover_module][:rover]
    @camera = params[:rover_module][:camera]
    @camera = "none" if @camera == nil

    respond_to do |format|

      temp_rover = ValidRoverDate.where("rover = ? AND camera = ?", @rover, @camera).first
      @sols = temp_rover.sols.split(",")
      format.js
    end

  end

  def process_rover
    @rover_full = params[:sol_group]
    rover,camera,date = @rover_full.split("-")
    rover_module = RoverModule.new(rover: rover, camera: camera, date: date)
    rover_module.save
    redirect_to rover_module
  end

  def show
    @rover_module = RoverModule.find(params[:id])
    @module_data = rover_request(@rover_module)

    @rover_module.page_number = 1
    @rover_module.picture_count = @module_data.length
    @rover_module.save
  end

  def more_pictures
    @rover_module = RoverModule.find(params[:id])
    rover_page = @rover_module.page_number + 1
    if request.xhr?
      @new_module_data = rover_page_request(@rover_module, rover_page)

      @rover_module.page_number = rover_page
      @rover_module.picture_count = @new_module_data.length
      @rover_module.save

      render json: { module_data: @new_module_data }
    else
      redirect_to @rover_module
    end
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

    def search_date_params
      params.permit(:rover, :camera)
    end

    def fix_date(initial_date)
      months = %w(January February March April May June July August September October November December)
      month = nil

      # find what month was selected
      months.each do |m|
        month = m if /#{m}/ =~ initial_date
      end

      # translate month word to number
      new_date = initial_date.gsub(month, (months.index(month) + 1).to_s)

      # Get the date set up to be split into an array of day-month-year
      new_date = new_date.gsub(',', '')
      new_date = new_date.gsub(' ', ',')

      date_ary = new_date.split(',')

      # convert world standard format to NASA desired format year-month-day
      new_date = "#{date_ary[2]}-#{date_ary[1]}-#{date_ary[0]}"

      return new_date
    end

    # sets up data for request, makes that request, and sends it through the
    # rover modules parser to get back an array of images, or the string no
    # data found
    def rover_request(rover_module)
      return rover_module.return_array(make_request(rover_module.build_query))
    end

    def rover_page_request(rover_module, page)
      return rover_module.return_array(make_request(rover_module.build_query_with_page(page)))
    end
end
