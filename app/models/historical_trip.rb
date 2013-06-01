class HistoricalTrip < ActiveRecord::Base
  include ActionView::Helpers

  def time_ago
    time_ago_in_words(Time.at(self.end_at))
  end

  def duration_time
    time = Time.at(duration/1000).utc.strftime('%H:%M:%S')
    time.sub(/^00:/, '')
  end

  def miles_rounded; miles.round(2); end
end
