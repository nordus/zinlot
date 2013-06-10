class Devices < Netzke::Basepack::Viewport

  component :devices do |c|
    c.klass = Netzke::Basepack::Grid
    c.model = "Device"
    c.columns = [
        {
            :name => :id,
            :width => '90px',
            :header => 'ID',
            :hidden => false
        },
        :device_type,
        :car_id,
        {
            :name => :vehicle,
            :width => '90px',
            :header => 'Vehicle',
            :hidden => false,
            :getter => lambda { |d|
              d.vehicle && d.vehicle.friendly_name
            }
        },
        :imei,
        :name,
        :sim_status,
        :activated_at,
        :created_at,
        :updated_at,
        :latest_history_id
    ]
  end

  js_configure do |c|
    c.layout = :border  # position bbar at bottom
  end

  def configure(c)
    super
    c.items = [
        { border:false, region:'north', html:'' },
        { border:false, region:'center', layout:'fit', items:[:devices] }
    ]
  end
end