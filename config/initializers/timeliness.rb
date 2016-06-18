ValidatesTimeliness.setup do |config|
  config.extend_orms = [ :active_record ]
  config.default_timezone = :utc
end
