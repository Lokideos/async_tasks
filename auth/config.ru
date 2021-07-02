require_relative 'config/environment'

if ENV['RACK_ENV'] == 'development'
  run ->(env) { Application.call(env) }
else
  run Application.freeze.app
end
