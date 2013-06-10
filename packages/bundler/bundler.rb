package :bundler do
  description "Bundler manages an application's dependencies"
  gem "bundler"
  verify do
    has_gem "bundler"
  end

  requires :ruby
end
