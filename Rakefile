#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

# I want these tasks local to the project, not in Rake's 'app' namespace
Dir.glob('tasks/*.rake').each { |r| import r }

Bundler::GemHelper.install_tasks

task default: :spec
