ruby '1.9.3'
source 'http://rubygems.org'

gem 'rails', '3.1.3'
gem 'pg'

group :production do
  gem 'rails_12factor'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'jquery-rails'
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem "rails-backbone"
  gem 'eco'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'simplecov', :require => false
end
