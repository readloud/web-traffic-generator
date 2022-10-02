json.array!(@urls) do |url|
  json.url url_url(url, format: :json)
end
