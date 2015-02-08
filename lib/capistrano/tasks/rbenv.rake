namespace :rbenv do
  ## rbenv deploy workaround
  set :default_environment, -> { {
    'PATH' => "/home/#{fetch(:user)}/.rbenv/shims:/home/#{fetch(:user)}/.rbenv/bin:$PATH"
  }}

  desc 'Update ruby version'
  task :update_rbenv do
    on roles(:app) do
      ruby_version = fetch(:ruby_version)

      run "cd ~/.rbenv/plugins/ruby-build && git pull"
      run "rbenv install #{ruby_version}"
      run "rbenv local #{ruby_version}"
      run "gem install bundler --no-ri --no-rdoc"

      run "rbenv rehash"
    end
  end

  desc 'Install RVM'
  task :install do
    on roles(:app) do
      ruby_version = fetch(:ruby_version)

      put bashrc, "/tmp/rbenvrc"
      run "cat /tmp/rbenvrc ~/.bashrc > ~/.bashrc.tmp"
      run "mv ~/.bashrc.tmp ~/.bashrc"
      run %q{export PATH="$HOME/.rbenv/bin:$PATH"}
      run %q{eval "$(rbenv init -)"}

      # Check if rbenv already installed
      cmd = <<-CMD
if [ ! -d $HOME/.rbenv/versions/#{ruby_version}/bin ]; then \
    rbenv install #{ruby_version} && \
    rbenv global #{ruby_version} && \
    gem install bundler --no-ri --no-rdoc && \
    rbenv rehash;
fi
CMD
      run cmd
    end
  end
end
