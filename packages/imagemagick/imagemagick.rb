package :imagemagick do
  description "Image Magick"
  apt "imagemagick libmagickwand-dev"
  verify do
    has_apt "imagemagick"
    has_apt "libmagickwand-dev"
  end
end
