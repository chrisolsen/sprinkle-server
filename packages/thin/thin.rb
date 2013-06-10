package :thin, :provides => :appserver do
  description 'Thin Web Server'

  requires :ruby
  requires :thin_configuration

  gem :thin

  verify do
    has_gem 'thin'
  end
end

# bundle exec thin --socket /tmp/thin.sock --server *3* --environment production --tag demo --rackup config.ru start
package :thin_configuration do
  description "Nginx as Reverse Proxy Configuration for Thin"

  requires :nginx

  locals = {
    thin_cluster_count: attributes[:thin][:cluster_count] || ask("Thin Cluster Count: "),
    server_addr:        attributes[:thin][:server_addr]   || ask("Server Url(s): "),
    root_path:          attributes[:thin][:root_path]     || ask("App root path: "),
  }

  src  = package_path 'thin/thin.conf'
  dest = "/etc/nginx/sites-available/#{attributes[:application]}.conf"
  sites_enabled = "/etc/nginx/sites-enabled/#{attributes[:application]}.conf"

  transfer(src, dest, render: true, sudo: true, locals: locals) do
    post :install, 'rm -f /etc/nginx/sites-available/default'
    post :install, 'rm -f /etc/nginx/sites-enabled/default'
    post :install, "ln -sf #{dest} #{sites_enabled}"
    post :install, '/etc/init.d/nginx restart'
  end

  verify do
    # TODO: allow matches_local method to compare a rendered erb template to server
    has_file dest
    # matches_local src, dest, render: true, locals: locals
  end
end
