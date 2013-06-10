class Cars < Netzke::Basepack::Viewport

  component :cars do |c|
    c.klass = Netzke::Basepack::Grid
    c.model = "Car"
    c.columns = [
        {
            :name => :id,
            :width => '40px',
            :header => 'ID',
            :hidden => false
        },
        :year,
        :make,
        :model
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
            { border:false, region:'center', layout:'fit', items:[:cars] }
        ]}
    ]
  end
end