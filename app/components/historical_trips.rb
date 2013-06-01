class HistoricalTrips < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "HistoricalTrip"
    c.bbar = [:search]
  end

  js_configure do |c|
    c.border = false
  end
end