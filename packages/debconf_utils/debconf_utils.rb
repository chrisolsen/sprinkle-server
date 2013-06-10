package :debconf_utils do
  apt 'debconf-utils'
  verify do
    has_apt "debconf-utils"
  end
end
