json.array!(@exoplanets) do |exoplanet|
  json.extract! exoplanet, :id, :name
  json.url exoplanet_url(exoplanet, format: :json)
end
