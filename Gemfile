source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"
gem "active_model_serializers", "~> 0.10.8"
gem "bootsnap", require: false
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4"
gem "sqlite3", "~> 1.4"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails', '~> 6.0.0'
  gem 'faker', '~> 2.0'
  gem 'rspec-rails', '~> 6.0.0'
end

group :test do
  gem 'database_cleaner', '~> 2.0'
  gem 'shoulda-matchers', '~> 5.0'
end
