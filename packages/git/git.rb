package :git, provides: :scm do
  description "Git Source Control"
  apt 'git-core'
  verify do
    has_apt 'git-core'
  end
end
