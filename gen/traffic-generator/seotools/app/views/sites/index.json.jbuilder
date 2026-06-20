json.array!(@sites) do |site|
  json.extract! site, :code, :domain, :campaign_id
  json.url site_url(site, format: :json)
end
