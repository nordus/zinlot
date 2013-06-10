class HistoricalTrips < Netzke::Basepack::Viewport

  component :historical_trips do |c|
    c.klass = Netzke::Basepack::Grid
    c.model = "HistoricalTrip"
    c.title = "Test Drives"
    c.bbar = [:search]
    c.columns = [
                  {
                      :name => :id,
                      :width => '40px',
                      :header => 'ID',
                      :hidden => false
                  },
                  {
                      :name => :vehicle,
                      :width => '120px',
                      :header => "Vehicle",
                      :getter => lambda {|t| t.device && t.device.vehicle && t.device.vehicle.car && t.device.vehicle.car.name }
                  },
                  {
                      :name => :miles,
                      :width => '50px',
                      :menu_disabled => true,
                      :header => "Miles",
                      :getter => lambda {|t| t.miles_rounded }
                  },
                  {
                      :name => :style,
                      :width => '110px',
                      :menu_disabled => true,
                      :header => "Style",
                      :getter => lambda { |t|
                        t.style
                      }
                  },
                  {
                      :name => :idle_minutes,
                      :width => '70px',
                      :header => "Idle",
                      :getter => lambda {|t| t.idle_minutes}
                  },
                  {
                      :name => :end,
                      :width => '120px',
                      :menu_disabled => true,
                      :header => "Age",
                      :getter => lambda { |t|
                        t.time_ago
                      }
                  },
                  {
                      :name => :duration_time,
                      :width => '60px',
                      :menu_disabled => true,
                      :header => "Duration",
                      :getter => lambda { |t|
                        t.duration_time
                      }
                  },
                  {
                      :name => :map,
                      :width => '50px',
                      :menu_disabled => true,
                      :header => "",
                      :getter => lambda { |t|
                        "<a href='/test-drives/#{t[:id]}' target='_'>map</a>"
                      }
                  }
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
        { border:false, region:'center', layout:'fit', items:[:historical_trips] }
      ]}
    ]
  end
end