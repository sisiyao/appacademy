@benches.each do |bench|
  json.set! bench.id do
    json.lat bench.lat
    json.lng bench.lng
    json.description bench.description
  end
end
