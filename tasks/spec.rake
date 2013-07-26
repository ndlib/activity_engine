task :spec do
  APP_RAKEFILE = File.expand_path("../../spec/dummy/Rakefile", __FILE__)
  load 'rails/tasks/engine.rake'
  require 'rails'
  require 'rspec/core/rake_task'
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
