class StaticPagesController < ApplicationController
  include GovApi

  def show
    # sets up nasa image of day
    nasa_data_search = ['explanation', 'hdurl', 'title']
    nasa_image_data = get_data(api_respond_json("https://api.nasa.gov/planetary/apod"), nasa_data_search)
    @nasa_image_title = nasa_image_data['title']
    @nasa_hd_image = nasa_image_data['hdurl']
    @nasa_image_explanation = nasa_image_data['explanation']
    @nasa_media_type = nasa_image_data['media_type']
  end
end
