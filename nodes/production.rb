set :user,      'sprinkle'
set :password,  'foobar'

# ssh_options[:keys] = `vagrant ssh_config | grep IdentityFile`.split.last.gsub('"', '')

role :app, "192.168.33.10", :primary => true

default_run_options[:pty] = true

