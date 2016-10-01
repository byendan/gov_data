module GovApi

  def make_request(query)
    api_key = ENV["GOV_API_KEY"]
    query += "api_key=#{api_key}"

    return JSON.parse Net::HTTP.get(URI(query))
  end
end
