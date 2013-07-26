namespace :dummy do
  desc "Generate a Rails dummy for ActivityEngine tests"
  task :generate => [:init, :new_app, :install, :migrate]

  desc 'Remove dummy application'
  task :remove => :init do
    require 'fileutils'
    $stdout.puts "Removing spec/dummy"
    DummyFileUtils.rm_rf(DUMMY_ROOT)
  end

  desc "Replace the existing Rails dummy for ActivityEngine tests"
  task :regenerate => [:remove, :generate]


  task :new_app => [:init, :guard] do
    # Cribbed from https://gist.github.com/stas/4131823
    require 'rails'
    require 'activity_engine'
    require 'rails/generators'
    require 'rails/generators/rails/plugin_new/plugin_new_generator'

    class DummyGenerator < Rails::Generators::PluginNewGenerator

      def self.default_source_root
        Rails::Generators::PluginNewGenerator.default_source_root
      end

      def do_nothing
      end

      alias :create_root :do_nothing
      alias :create_root_files :do_nothing
      alias :create_app_files :do_nothing
      alias :create_config_files :do_nothing
      alias :create_lib_files :do_nothing
      alias :create_public_stylesheets_files :do_nothing
      alias :create_javascript_files :do_nothing
      alias :create_script_files :do_nothing
      alias :update_gemfile :do_nothing
      alias :create_test_files :do_nothing
      alias :finish_template :do_nothing

    end
    puts "Generating #{DUMMY_ROOT}"
    DummyGenerator.start(
      %W(. --force --skip-bundle --old-style-hash --dummy-path=#{DUMMY_ROOT})
    )
  end

  task :install => [:init, :new_app] do
    puts "Installing ActivityEngine"
    require 'generators/activity_engine/install_generator'
    ActivityEngine::Generators::InstallGenerator.start(
      %W(. --force )
    )
  end
  task :migrate => :init do
    puts "Running activity_engine migrations"
    rakefile = File.join(DUMMY_ROOT, 'Rakefile')
    system("rake -f #{rakefile} db:create db:migrate db:test:prepare")
  end

  task :init do
    DummyFileUtils = FileUtils #::DryRun
    DUMMY_ROOT = File.expand_path("../../spec/dummy", __FILE__).freeze
  end

  task :guard => [:init] do
    if File.exist?(File.join(DUMMY_ROOT, 'Rakefile'))
      $stderr.puts "Dummy rakefile already exists"
      exit!(-1)
    end
  end

end
