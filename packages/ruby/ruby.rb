package :ruby do
  version attributes[:ruby][:version]


  gem_version = attributes[:ruby][:gem_version]

  source "ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-#{version}.tar.gz" do
    post :install, "gem install rubygems-update -v#{gem_version}"
  end

  verify do
    has_executable_with_version "ruby", version.gsub('-', ''), '-v'
  end
end
