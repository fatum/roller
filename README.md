# Roller

Roller provides

* tasks for generation nginx, unicorn, rbenv, logrotate etc. config files
* generator for deploy config files
* based on Capistrano 3.x

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

Tasks

* `rbenv:install` downloads rbenv and install provided ruby version
* `rbenv:update` updates available ruby versions and install new reby version

Variables

* `ruby_version` default is 2.1.1

## Contributing

1. Fork it ( https://github.com/[my-github-username]/roller/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request