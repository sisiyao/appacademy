@benches.each do |bench|
  json.set! bench.id do
    json.id bench.id
    json.lat bench.lat
    json.lng bench.lng
    json.description bench.description
  end
end
