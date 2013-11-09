json.array!(@planets) do |planet|
  json.extract! planet, :name
  json.url planet_url(planet, format: :json)
end
