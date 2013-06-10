package :build_essential do
  description 'Build tools'
  apt 'build-essential' do
    pre :install, 'aptitude update'
    pre :install, 'locale-gen en_GB.UTF-8'
    pre :install, '/usr/sbin/update-locale LANG=en_GB.UTF-8'
    pre :install, 'aptitude safe-upgrade -y'
    pre :install, 'aptitude full-upgrade'
  end

  # removed libreadline5-dev due to postfix
  libs = %w[ zlib1g-dev libpcre3-dev libssl-dev libcurl4-openssl-dev libreadline6-dev libreadline-dev libxml2-dev libxslt1-dev wget less bash-completion curl rsync locate nmap tree libyaml-dev libffi-dev ]
  libs.each do |lib|
    apt lib
  end

  verify do
    has_apt 'build-essential'
    libs.each do |lib|
      puts "has_apt #{lib}"
    end
  end
end
