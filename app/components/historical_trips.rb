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
                      :name => :device_id,
                      :width => '70px',
                      :header => "Device"
                  },
                  {
                      :name => :miles,
                      :width => '50px',
                      :header => "Mi"
                  },
                  {
                      :name => :highest_speed,
                      :width => '40px',
                      :header => "Max speed"
                  },
                  {
                      :name => :num_speed_event,
                      :width => '40px',
                      :header => "# speed"
                  },
                  {
                      :name => :num_rpm_event,
                      :width => '40px',
                      :header => "RPM"
                  },
                  {
                      :name => :num_hard_brake,
                      :width => '40px',
                      :header => "Brake"
                  },
                  {
                      :name => :num_very_hard_brake,
                      :width => '40px',
                      :header => "! Brake"
                  },
                  {
                      :name => :num_hard_accel,
                      :width => '40px',
                      :header => "Accel"
                  },
                  {
                      :name => :num_very_hard_accel,
                      :width => '40px',
                      :header => "! Accel"
                  },
                  {
                      :name => :num_corner_l,
                      :width => '40px',
                      :header => "Left"
                  },
                  {
                      :name => :num_hard_corner_l,
                      :width => '40px',
                      :header => "! Left"
                  },
                  {
                      :name => :num_corner_r,
                      :width => '40px',
                      :header => "Right"
                  },
                  {
                      :name => :num_hard_corner_r,
                      :width => '40px',
                      :header => "! Right"
                  },
                  {
                      :name => :ending_mileage,
                      :width => '40px',
                      :header => "Mileage"
                  },
                  {
                      :name => :idle_seconds,
                      :width => '50px',
                      :header => "Idle sec"
                  },
                  {
                      :name => :end,
                      :width => '80px',
                      :menu_disabled => true,
                      :header => "",
                      :getter => lambda { |t|
                        t.time_ago
                      }
                  },
                  {
                      :name => :duration_time,
                      :width => '50px',
                      :menu_disabled => true,
                      :header => "",
                      :getter => lambda { |t|
                        t.duration_time
                      }
                  },
                  {
                      :name => :map,
                      :width => '40px',
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
      { border:false, region:'north', html:header_html },
      { border:false, region:'center', layout:'fit', items:[:historical_trips] }
    ]
  end

  def header_html
    %Q{
      <div data-theme="c" data-role="header" class="jqm-header ui-header ui-bar-c" role="banner">
        <h1 class="ui-title" role="heading" aria-level="1">
          <a id="logo" href="/" class="ui-link">ZinLot</a>
        </h1>
        <a href="#historical_trips-index-navmenu" data-iconpos="notext" data-icon="bars" class="jqm-navmenu-link ui-btn-left ui-btn ui-btn-up-c ui-shadow ui-btn-corner-all ui-btn-icon-notext" data-corners="true" data-shadow="true" data-iconshadow="true" data-wrapperels="span" data-theme="c" title=""><span class="ui-btn-inner"><span class="ui-btn-text"></span><span class="ui-icon ui-icon-bars ui-icon-shadow">&nbsp;</span></span></a>
      </div>
    }
  end
end