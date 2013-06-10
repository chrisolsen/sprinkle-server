package :ssh do

  user = attributes[:user]
  addr = attributes[:server][:address]

  id_path     = file_path('id_rsa')
  id_pub_path = file_path('id_rsa.pub')

  transfer id_path,     "~/.ssh/id_rsa",     sudo: true
  transfer id_pub_path, "~/.ssh/id_rsa.pub", sudo: true

  runner "chown -R vagrant:vagrant ~/.ssh", sudo: true
  runner "chmod 600 ~/.ssh/id_rsa"

  verify do
    matches_local   id_path,      '~/.ssh/id_rsa'
    matches_local   id_pub_path,  '~/.ssh/id_rsa.pub'
    belongs_to_user '~/.ssh/id_rsa', user
    has_permission  '~/.ssh/id_rsa', '600'
  end
end
