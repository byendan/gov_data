module GovApi
  def get_data(api_json_response, desired_data)
    final_data = Hash.new

    desired_data.each do |data_name|
      final_data[data_name] = api_json_response[0][data_name]
    end

    return final_data

  end

  def api_respond_json(api_url)
    api_key = ENV["GOV_API_KEY"]
    address = "#{api_url}?api_key=#{api_key}"

    return JSON.parse Net::HTTP.get(URI(address))
  end
end
