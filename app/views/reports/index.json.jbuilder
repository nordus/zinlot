json.array!(@reports) do |report|
  json.extract! report, :q, :interval, :format, :user_id, :name, :time, :time_zone
  json.url report_url(report, format: :json)
end