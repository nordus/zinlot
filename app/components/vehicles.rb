class Vehicles < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Vehicle"
  end

  js_configure do |c|
    c.border = false
  end
end