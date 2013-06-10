package :nginx, provides: :webserver do
  description "Nginx web server"

  apt "nginx"

  verify do
    has_apt "nginx"
  end
end
