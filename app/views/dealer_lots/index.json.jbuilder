json.array!(@dealer_lots) do |dealer_lot|
  json.extract! dealer_lot, :id, :name
end