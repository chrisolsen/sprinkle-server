package :vim do
  apt "vim"

  verify do
    has_apt "vim"
  end
end
