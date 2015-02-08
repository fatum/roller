namespace :deploy do
  set :full_app_name, "#{fetch(:application)}-#{fetch(:stage)}"

  set :repository_cache, "git_cache"
  set :deploy_to, -> { File.join(fetch(:root_dir), fetch(:application), fetch(:stage).to_s) }

  set :root_dir, -> { "/home/#{fetch(:user)}" }

  set :scm_verbose, true

  set :branch, ENV["REVISION"] || ENV["BRANCH"] || "master"
  set :repo_host, 'git.bitbucket.org'

  # set :linked_files, %w{config/database.yml}
  # dirs we want symlinking to shared
  set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets}
end

