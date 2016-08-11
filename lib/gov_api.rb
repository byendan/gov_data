module GovApi

  def make_request(query)
    api_key = ENV["GOV_API_KEY"]
    query += "api_key=#{api_key}"

    return JSON.parse Net::HTTP.get(URI(query))
  end


  def get_data(api_json_response, desired_data)
    final_data = Hash.new

    desired_data.each do |data_name|
        final_data[data_name] = api_json_response[data_name]
    end

    if final_data[final_data.keys.first] == nil
      final_data = find_data(api_json_response, desired_data[0])
    end


    return final_data

  end

  def api_respond_json(api_url, options={})
    api_key = ENV["GOV_API_KEY"]

    address="#{api_url}?"

    options.each do |key, value|
      address += "#{key}=#{value}&"
    end

    address += "api_key=#{api_key}"

    return JSON.parse Net::HTTP.get(URI(address))
  end

  def find_data(json_data, desired_data)
    all_data = []

    json_data.each do |key, value|
      if json_data[key].class == String
        return "no data found"
      end
      json_data[key].each do |pic_hash|
        all_data << pic_hash[desired_data]
      end
    end


    return all_data
  end
end
