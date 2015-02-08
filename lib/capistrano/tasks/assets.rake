namespace :deploy do
  task :assets => :deploy do
    invoke :compile_assets_locally
  end

  desc "Compiles assets locally then rsyncs"
  task :compile_assets_locally do
    run_locally do
      execute "RAILS_ENV=#{fetch(:rails_env)} bundle exec rake assets:precompile"
    end

    on roles(:app) do |role|
      run_locally do
        execute "rsync -av ./public/assets/ #{role.user}@#{role.hostname}:#{shared_path}/public/assets/;"
      end

      sudo "chmod -R 755 #{shared_path}/public/assets/"
    end

    run_locally do
      execute "rm -rf ./public/assets"
    end
  end
end
