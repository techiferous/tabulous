json.array!(@stars) do |star|
  json.extract! star, :name
  json.url star_url(star, format: :json)
end
