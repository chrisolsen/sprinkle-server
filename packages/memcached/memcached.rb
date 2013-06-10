package :memcached do
  description "Memcached"
  apt 'memcached'
  verify do
    has_apt 'memcached'
  end
end
