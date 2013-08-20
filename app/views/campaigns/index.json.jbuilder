json.array!(@campaigns) do |campaign|
  json.extract! campaign, 
  json.url campaign_url(campaign, format: :json)
end
