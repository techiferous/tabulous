json.array!(@galaxies_elliptical_galaxies) do |galaxies_elliptical_galaxy|
  json.extract! galaxies_elliptical_galaxy, :name
  json.url galaxies_elliptical_galaxy_url(galaxies_elliptical_galaxy, format: :json)
end