json.array!(@galaxies_lenticular_galaxies) do |galaxies_lenticular_galaxy|
  json.extract! galaxies_lenticular_galaxy, :id, :name
  json.url galaxies_lenticular_galaxy_url(galaxies_lenticular_galaxy, format: :json)
end
