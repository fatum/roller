namespace :rbenv do
  ## rbenv deploy workaround
  set :default_environment, -> { {
    'PATH' => "/home/#{fetch(:user)}/.rbenv/shims:/home/#{fetch(:user)}/.rbenv/bin:$PATH"
  }}

  set :ruby_version, "2.1.2"

  desc 'Update ruby version'
  task :update do
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

      sudo "apt-get update"
      sudo "apt-get -y install curl imagemagick libmysqlclient-dev git-core gcc g++ make libssl-dev"

      execute "curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash"

      bashrc = <<-BASHRC
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
      BASHRC

      upload! StringIO.new(bashrc), "/tmp/rbenvrc"

      execute "cat /tmp/rbenvrc ~/.bashrc > ~/.bashrc.tmp"
      execute "mv ~/.bashrc.tmp ~/.bashrc"
      execute %q{export PATH="$HOME/.rbenv/bin:$PATH"}
      execute %q{eval "$(rbenv init -)"}

      if test("! -d $HOME/.rbenv/versions/#{ruby_version}/bin")
        # Check if rbenv already installed
        cmd = <<-CMD
rbenv install #{ruby_version} && \
rbenv global #{ruby_version} && \
gem install bundler --no-ri --no-rdoc && \
rbenv rehash;
        CMD
        execute cmd
      end
    end
  end
end
