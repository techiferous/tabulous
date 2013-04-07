json.array!(@exoplanets) do |exoplanet|
  json.extract! exoplanet, :name
  json.url exoplanet_url(exoplanet, format: :json)
end