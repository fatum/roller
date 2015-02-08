require 'thor'

module Roller
  class Cli < Thor
    include Thor::Actions

    method_option :rails, type: :boolean, default: true
    method_option :ruby, type: :boolean, default: true

    argument :name
    desc "init NAME", "Generate deployment configs"
    def init
      template 'config/deploy.rb.erb', destination_to("config/deploy.rb")

      copy_file 'config/shared/logrotate.conf.erb', destination_to('config/deploy/shared/logrotate.conf.erb')
      copy_file 'config/shared/nginx.conf.erb', destination_to('config/deploy/shared/nginx.conf.erb')

      if ruby?
        copy_file 'config/shared/unicorn.rb.erb', destination_to('config/deploy/shared/unicorn.rb.erb')
        copy_file 'config/shared/unicorn_init.sh.erb', destination_to('config/deploy/shared/unicorn_init.sh.erb')
      end

      append_to_gemfile 'capistrano-bundler' if bundler?
      append_to_gemfile 'capistrano-rbenv' if rbenv?
      append_to_gemfile 'capistrano-rails' if rails?
    end

    private

    def append_to_gemfile(gem)
      create_file destination_to("Gemfile") if not File.exists? destination_to("Gemfile")

      append_to_file destination_to("Gemfile") do
        "gem '#{gem}', group: :development\n"
      end
    end

    def destination_to(path)
      destination = ENV['LOCAL'] ? "sample" : "./"
      File.join(destination, path)
    end

    def bundler?
      rails? || ruby?
    end

    def rbenv?
      bundler?
    end

    def rails?
      options[:rails]
    end

    def ruby?
      options[:ruby] || options[:rails]
    end

    def self.source_root
      File.expand_path "./../../templates", File.dirname(__FILE__)
    end
  end
end
