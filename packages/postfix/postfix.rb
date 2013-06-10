package :postfix, provides: :mailserver do
  description 'Postfix'

  preseed_dest = '/tmp/postfix.preseed'
  preseed_src  = File.join File.dirname(__FILE__), 'postfix.preseed'

  transfer preseed_src, preseed_dest

  apt 'postfix' do
    pre  :install, "debconf-set-selections #{preseed_dest}"
    post :install, "rm #{preseed_dest}"
  end

  verify do
    has_apt 'postfix'
  end
end
