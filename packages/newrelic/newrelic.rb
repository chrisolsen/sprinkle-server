package :newrelic do
  gem 'newrelic_rpm'

  verify do
    has_gem 'newrelic_rpm'
  end

  requires :newrelic_server
end

package :newrelic_server do

  apt 'newrelic-sysmond' do
    post :install, "nrsysmond-config --set license_key=#{attributes[:newrelic][:license_key]}"
    post :install, '/etc/init.d/newrelic-sysmond start'
  end

  verify do
    has_apt 'newrelic-sysmond'
  end

  requires :newrelic_server_requirements
end

package :newrelic_server_requirements do
  apt_url       = 'http://download.newrelic.com/debian/newrelic.list'
  newrelic_key  = attributes[:new_relic][:key]

  runner "wget -O /etc/apt/sources.list.d/newrelic.list #{apt_url}", sudo: true
  runner "apt-key adv --keyserver hkp://subkeys.pgp.net --recv-keys #{newrelic_key}" do
    post :install, 'aptitude update'
  end

  verify do
    has_file '/etc/apt/sources.list.d/newrelic.list'
  end
end
