set :user,      'vagrant'
set :password,  'vagrant'

role :app, "192.168.33.10", :primary => true

# default_run_options[:pty] = true
