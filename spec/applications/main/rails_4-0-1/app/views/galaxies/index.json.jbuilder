json.array!(@galaxies) do |galaxy|
  json.extract! galaxy, :name
  json.url galaxy_url(galaxy, format: :json)
end
