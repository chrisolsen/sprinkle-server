package :mysql, provides: :database do
  description "Mysql Server / Client"

  preseed_dest = '/tmp/mysql.preseed'
  preseed_src  = package_path 'mysql/mysql.preseed'

  transfer preseed_src, preseed_dest, render: true, locals: {
    password: attributes[:database][:password] || ask("Database Password:")
  }

  apt ["mysql-server", "mysql-client", "libmysqlclient-dev"] do
    pre  :install, "debconf-set-selections #{preseed_dest}"
    post :install, "rm #{preseed_dest}"
  end

  verify do
    has_apt "mysql-server"
    has_apt "mysql-client"
  end
end

package :mysql_driver, :provides => :ruby_database_driver do
  description 'Ruby MySQL database driver'
  gem 'mysql2'

  verify do
    has_gem 'mysql2'
  end

  requires :ruby
end
