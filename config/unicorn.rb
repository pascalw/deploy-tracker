worker_processes 1
timeout 30
preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    env = ENV['RACK_ENV'] || 'development'
    config = YAML::load(ERB.new(File.read('config/database.yml')).result)[env]
    ActiveRecord::Base.establish_connection(config)
  end
end
