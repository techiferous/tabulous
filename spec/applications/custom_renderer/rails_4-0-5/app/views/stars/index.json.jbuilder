json.array!(@stars) do |star|
  json.extract! star, :id, :name
  json.url star_url(star, format: :json)
end
