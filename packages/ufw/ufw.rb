package :ufw do
  apt "ufw"

  # these are not being run since ufw is installed by default
  # and even if they do run ufw requires user input to confirm the restart
  # do debconf-xxx-selections exist
  runner [
    'ufw disable',
    'ufw default deny',

    'ufw allow to any port ssh',
    'ufw allow to any port http',
    'ufw allow to any port https',

    'ufw deny to any port smtp',

    'ufw enable'
  ], sudo: true

  verify do
    has_apt "ufw"
  end
end
