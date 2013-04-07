json.array!(@planets_rogue_planets) do |planets_rogue_planet|
  json.extract! planets_rogue_planet, :name
  json.url planets_rogue_planet_url(planets_rogue_planet, format: :json)
end