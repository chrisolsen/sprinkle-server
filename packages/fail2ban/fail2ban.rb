package :fail2ban do
  apt :fail2ban
  verify { has_apt :fail2ban }
end
