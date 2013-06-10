package :logrotate do
  apt :logrotate
  verify { has_apt :logrotate }
end
