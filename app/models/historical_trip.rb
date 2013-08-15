class HistoricalTrip < ActiveRecord::Base
  include ActionView::Helpers

  default_scope -> { order('id DESC') }

  belongs_to :device

  attr_protected :created_at

  before_save :add_trip_number
  before_save :check_geofence_violations

  def check_geofence_violations
    self.has_geofence_violations = boundary_violations?
  end

  def add_trip_number
    self.trip_number = HistoricalTrip.where({device_id: device_id}).count + 1
  end

  # check to see if
  # we exited any boundaries
  def boundary_violations?
    violated_a_boundary = 0

    geofence_violations = GeofenceViolation.where({ trip_start_at:start_at })

    if geofence_violations.count > 0
      geofence_ids = geofence_violations.pluck('geofence_id')

      for geofence_id in geofence_ids
        if Geofence.is_boundary(geofence_id)
          violated_a_boundary = 1
        end
      end
    end

    return violated_a_boundary
  end

  def time_ago
    time_ago_in_words(Time.at(self.end_at)) + ' ago'
  end

  def duration_time(duration: duration)
    time = Time.at(duration/1000).utc.strftime('%H:%M:%S')
    time.sub(/^00:/, '')
  end

  def miles_rounded(miles: miles); miles.round(2); end

  def style
    total_events = 0
    [:num_hard_brake, :num_hard_accel, :num_speed_event, :num_rpm_event, :num_corner_l, :num_corner_r, :num_very_hard_brake, :num_very_hard_accel, :num_hard_corner_l, :num_hard_corner_r].each do |attr|
      if self[attr] && self[attr] > 0
        total_events += self[attr]
      end
    end

    if total_events < 5
      return 'Safe'
    elsif total_events < 9
      return 'Agressive'
    else
      return 'Very Agressive'
    end
  end

  def idle_minutes
    if idle_seconds == 0
      return ''
    end
    time = Time.at(idle_seconds).utc.strftime('%H:%M:%S')
    time.sub(/^00:/, '')
  end
end
