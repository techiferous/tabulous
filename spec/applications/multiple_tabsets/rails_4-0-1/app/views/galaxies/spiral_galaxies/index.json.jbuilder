json.array!(@galaxies_spiral_galaxies) do |galaxies_spiral_galaxy|
  json.extract! galaxies_spiral_galaxy, :name
  json.url galaxies_spiral_galaxy_url(galaxies_spiral_galaxy, format: :json)
end
