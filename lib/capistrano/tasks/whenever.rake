namespace :whenever do
  set :whenever_identifier, -> { "#{fetch(:full_app_name)}" }
  set :whenever_environment, -> { fetch(:rails_env) }
  set :whenever_roles, :whenever
end
