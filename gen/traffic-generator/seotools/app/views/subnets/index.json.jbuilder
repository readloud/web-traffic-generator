json.array!(@subnets) do |subnet|
  json.extract! subnet, :ip
  json.url subnet_url(subnet, format: :json)
end
