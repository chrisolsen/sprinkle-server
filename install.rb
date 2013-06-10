#TODO:
# * backups (database, images, etc)
# * get Thin working
# * add the nginx maintenance file if block

require './lib/helpers'

SPRINKLE_ROOT = File.expand_path(File.dirname(__FILE__))
Dir.glob("#{SPRINKLE_ROOT}/packages/**/*.rb").each do |package|
  require package
end

# specify which packages to install
policy :myapp, :roles => :app do
  requires :build_essential
  requires :ssh

  requires :appserver
  requires :backup
  requires :bundler
  requires :database
  requires :debconf_utils
  requires :fail2ban
  requires :imagemagick
  requires :logrotate
  requires :mailserver
  requires :monit
  requires :newrelic
  requires :ruby
  requires :scm
  requires :vim
  requires :webserver
end

# set how the installs will be performed
deployment do
  delivery :capistrano do
    recipes "./nodes/#{env}.rb"
  end

  source do
    prefix   '/usr/local'           # where all source packages will be configured to install to
    archives '/usr/local/sources'   # where all source packages will be downloaded to
    builds   '/usr/local/build'     # where all source packages will be built
  end
end
