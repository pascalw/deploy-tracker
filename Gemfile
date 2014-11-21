ruby '2.1.4'
source 'https://rubygems.org'

gem 'sinatra', '~> 1.4.5'
gem 'sinatra-activerecord', '~> 2.0.3'
gem 'activerecord', '~> 4.1.8'
gem 'rake', '~> 10.3.2'
gem 'racksh', '~> 1.0.0'

group :development, :test do
  gem 'sqlite3', '~> 1.3.10'
  gem 'rspec', '~> 3.1.0'
end

group :production do
  gem 'pg'
  gem 'unicorn'
end
