module GovApi
  def get_data(api_url, desired_data)
    api_key = ENV["GOV_API_KEY"]
    address = "#{api_url}?api_key=#{api_key}"

    body = JSON.parse Net::HTTP.get(URI(address))

    return the_data(body, desired_data)

  end

  private

    def the_data(body_hash, desired_data_array)
      final_data = Hash.new

      desired_data_array.each do |data_name|
        final_data[data_name] = body_hash[data_name]
      end

      return final_data

    end
end
