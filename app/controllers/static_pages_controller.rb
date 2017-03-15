class StaticPagesController < ApplicationController
  include GovApi

  def front
    # Astronomical picture of the day(APOD)
    @apod_module = get_apod
  
  end

  private

    def get_apod
      apod_query = 'https://api.nasa.gov/planetary/apod?'
      apod_data = structure_apod_data(make_request(apod_query))
    end

    def structure_apod_data(json_response)
      return_data = {
        title: json_response["title"],
        description: json_response["explanation"],
        img_url: json_response["hdurl"] || json_response["url"]
      }
    end
end
