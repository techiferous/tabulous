json.array!(@galaxies) do |galaxy|
  json.extract! galaxy, :id, :name
  json.url galaxy_url(galaxy, format: :json)
end
