class HistoricalTrips < Netzke::Basepack::Viewport

  component :historical_trips do |c|
    c.klass = Netzke::Basepack::Grid
    c.model = "HistoricalTrip"
    c.title = "Test Drives"
    c.bbar = [:search]
    c.columns = [
                  {
                    :name => :map,
                    :header => "",
                    :getter => lambda { |t|
                      "<a href='/test-drives/#{t[:id]}'>map</a>"
                    }
                  },
                  :device_id,
                  {
                    :name => :end,
                    :header => "Time ago",
                    :getter => lambda { |t|
                      t.time_ago
                    }
                  },
                  {
                    :name => :duration_time,
                    :header => "Duration",
                    :getter => lambda { |t|
                      t.duration_time
                    }
                  },
                  {
                    :name => :miles_rounded,
                    :header => "Miles",
                    :getter => lambda { |t|
                      t.miles_rounded
                    }
                  },
                  :start_at,
                  :end_at,
                  :num_hard_brake,
                  :num_hard_accel,
                  :num_speed_event,
                  :num_rpm_event,
                  :ending_mileage,
                  :highest_speed,
                  :idle_seconds,
                  :num_corner_l,
                  :num_corner_r,
                  :num_very_hard_brake,
                  :num_very_hard_accel,
                  :num_hard_corner_l,
                  :num_hard_corner_r
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