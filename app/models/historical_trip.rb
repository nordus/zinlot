class HistoricalTrip < ActiveRecord::Base
  include ActionView::Helpers

  default_scope :order => 'id DESC'

  def time_ago
    time_ago_in_words(Time.at(self.end_at)) + ' ago'
  end

  def duration_time
    time = Time.at(duration/1000).utc.strftime('%H:%M:%S')
    time.sub(/^00:/, '')
  end

  def miles_rounded; miles.round(2); end
end
