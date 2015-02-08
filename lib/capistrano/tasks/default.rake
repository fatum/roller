namespace :deploy do
  set :full_app_name, "#{fetch(:application)}-#{fetch(:stage)}"

  set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || "master"
  set :repo_host, 'git.bitbucket.org'

  set :linked_files, %w{config/database.yml}
  # dirs we want symlinking to shared
  set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}
end

