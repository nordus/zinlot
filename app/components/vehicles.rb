class Vehicles < Netzke::Basepack::Viewport

  component :vehicles do |c|
    c.klass = Netzke::Basepack::Grid
    c.model = "Vehicle"
    c.columns = [
        {
            :name => :id,
            :width => '40px',
            :header => 'ID',
            :hidden => false
        },
        :vehicle_mileage,
        :car_color,
        {:name => :car__name, :header => 'Car', width: '200px'},
        {:name => :vehicle_usage__name, :header => 'Usage'}
    ]
  end

  js_configure do |c|
    c.layout = :border  # position bbar at bottom
  end

  def configure(c)
    super
    c.items = [
        { region: :west, item_id: :navigation, width: 150, split: false },
        { region: :center, layout: :border, border: false, items: [
            { border:false, region:'center', layout:'fit', items:[:vehicles] }
        ]}
    ]
  end
end