if Rails.env.development?
  Rack::MiniProfiler.config.position = 'bottom-left'
  # Rack::MiniProfiler.config.start_hidden = true
end
