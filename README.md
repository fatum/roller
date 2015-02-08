# Roller

#### Roller provides

* tasks for generation nginx, unicorn, rbenv, logrotate etc. config files
* generation deploy files
* code based on Capistrano 3.x

## Installation

Add this line to your application's Gemfile:

    gem 'roller', github: 'fatum/roller'

And then execute:

    $ bundle

## Usage

Roller support these commands

* `roller init NAME` generates config files and appends gems into Gemfile

Available deploy tasks

### rbenv

`require 'roller/tasks/rbenv'`

#### Tasks

* `rbenv:install` downloads rbenv and install provided ruby version
* `rbenv:update` updates available ruby versions and install new reby version

#### Variables

* `ruby_version` default is 2.1.1

### SSH

`require 'roller/tasks/ssh'`

#### Tasks

* `ssh:setup` upload ssh keys and update known_hosts with fingerprint

#### Variables

* `ssh_key_path` path to ssh keys (config/deploy/ssh)
* `ssh_repo_host` host which adds into known_hosts

### Assets

`require 'roller/tasks/assets'`

#### Tasks

* `deploy:compile_assets_locally` compile assets locally and upload it using rsync

### Nginx

`require 'roller/tasks/nginx'`

#### Tasks

* `nginx:[start|stop|restart|reload]` nginx's commands
* `nginx:remove_default_vhost`

#### Variables

* `nginx_port`
* `nginx_server_name`
* `nginx_ssl` flag for enabling ssl mode

### Setup Configuration

`require 'roller/tasks/setup_config'`

#### Tasks

* `deploy:setup_config`

#### Variables

* `config_files` These files compiles using ERB and uploads to shared_path/config/

```ruby
set(:config_files, %w(
  nginx.conf
  unicorn.rb
  unicorn_init.sh
  database.yml
))
```

* `symlinks` Compiled files can be symlinked into /etc/

```ruby
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/app-{{full_app_name}}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/app-{{full_app_name}}-unicorn"
  },
  {
    source: "logrotate",
    link: "/etc/logrotate.d/app-{{full_app_name}}"
  },
])
```

## TODO

* Use https://github.com/sonots/capistrano-bundle_rsync

## Contributing

1. Fork it ( https://github.com/[my-github-username]/roller/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
