ActiveAdmin.register HistoricalTrip do

  member_action :show_map do
    @trip = HistoricalTrip.find(params[:id])
    @start_at = @trip[:start_at] * 1000
    @end_at = @trip[:end_at] * 1000
    @device_id = @trip[:device_id]
  end

  zone = 'America/Phoenix'

  index do
    column :map do |trip|
      link_to 'Show', "#{admin_historical_trip_path(trip)}/show_map"
    end

    column :device_id
    
    column :start_at do |trip|
      Time.at(trip.start_at).in_time_zone(zone).strftime('%b %d %l:%M %p')
    end
    
    column :end_at do |trip|
      Time.at(trip.end_at).in_time_zone(zone).strftime('%b %d %l:%M %p')
    end
    
    column :duration do |trip|
      time = Time.at(trip.duration/1000).utc.strftime('%H:%M:%S')
      time_str = time.sub(/^00:/, '')
      time_str
    end
    
    column :miles do |trip|
      trip.miles.round(2)
    end
    
    column :ending_mileage do |trip|
      trip.ending_mileage.round(2)
    end

    column 'Enter Geo', :num_enter_geo_zone

    column 'Exit Geo', :num_exit_geo_zone

    column :highest_speed do |trip|
      trip.highest_speed.round(0)
    end
    
    column :idle_seconds
    
    column 'Speed Event', :num_speed_event
    
    column 'RPM Event', :num_rpm_event
    
    column 'Hard Brake', :num_hard_brake
    
    column 'Hard Accel', :num_hard_accel
    
    column 'Very Hard Brake', :num_very_hard_brake
    
    column 'Very Hard Accel', :num_very_hard_accel
    
    column 'Corner L', :num_corner_l
    
    column 'Corner R', :num_corner_r
    
    column 'Hard Corner L', :num_hard_corner_l
    
    column 'Hard Corner R', :num_hard_corner_r
    
    column :fuel_gal_start
    
    column :fuel_gal_end
  end

end
