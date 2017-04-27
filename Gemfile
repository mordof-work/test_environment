source 'https://rubygems.org'

if ENV['OLD']
  gem 'activesupport', '4.1.5'
  gem 'activemodel', '4.1.5'
  gem 'activerecord', '4.1.5'
else
  gem 'activesupport', '5.0.2'
  gem 'activemodel', '5.0.2'
  gem 'activerecord', '5.0.2'
end

if ENV['NULLDB']
  gem 'activerecord-nulldb-adapter'
else
  gem 'pg'
end

gem 'require_all'
gem 'byebug', '>= 8.1.0'
gem 'pry-byebug', '>= 3.3.0'
