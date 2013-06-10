package :monit_service do

  apt :monit

  verify do
    has_apt :monit
  end
end

package :monit do
  requires :monit_service

  templates = [
    :mysql,
    :newrelic,
    :nginx,
    :server,
    :memcached,
    :fail2ban,
  ]

  attrs = attributes[:monit]

  templates.each do |template|
    src_path  = package_path "monit/templates/#{template}.monitrc"
    dest_path = "/etc/monit/conf.d/#{template}.monitrc"
    transfer src_path, dest_path, sudo: true, render: true, locals: attrs[template]
  end

  [:monitrc, :monit].each do |file|
    src  = package_path "monit/templates/#{file}"
    dest = "/etc/monit/#{file}"
    transfer src, dest, sudo: true
  end

  verify do
    templates.each do |template|
      has_file "/etc/monit/conf.d/#{template}.monitrc"
    end
    has_file "/etc/monit/monitrc"
  end
end
