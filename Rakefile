#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

task :spec do
  ENV['RAILS_ENV'] = 'test'
  Rails.env = 'test'
  Rake::Task["db:drop"].invoke rescue true
  Rake::Task["db:create"].invoke
  Rake::Task['environment'].invoke
  Rake::Task['db:schema:load'].invoke
  RSpec::Core::RakeTask.new(:__spec) do |t|
    t.pattern = "./spec/**/*_spec.rb"
  end
  Rake::Task['__spec'].invoke
end

task default: :spec
