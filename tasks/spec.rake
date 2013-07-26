task :spec => ['dummy:regenerate'] do
  require 'rails'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:rspec) do |t|
    t.pattern = '../**/*_spec.rb'
    # Because we are running in the context of the dummy app, we need to
    # make sure that spec_helper.rb is somewhere in the load path.
    # Thus the "-I ../"
    t.rspec_opts = "--colour -I ../"
  end
  Rake::Task['rspec'].invoke
end
