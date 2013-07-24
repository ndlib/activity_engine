source "http://rubygems.org"

# Declare your gem's dependencies in activity_engine.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'


group :test do
  gem 'growl'
  gem 'guard'
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false if RUBY_PLATFORM =~ /darwin/i
  gem 'rb-fchange', require: false
  gem 'terminal-notifier-guard' if RUBY_PLATFORM =~ /darwin/i 
  gem 'simplecov', require: false
  gem "guard"
  gem "guard-rspec"
  gem 'guard-bundler'
  gem 'database_cleaner'
end
