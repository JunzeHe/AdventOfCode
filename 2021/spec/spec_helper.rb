ENV['RAILS_ENV'] ||= 'test'

puts "RUBY_ENGINE: #{RUBY_ENGINE}"
puts "RUBY_VERSION: #{RUBY_VERSION}\n\n"

##
# Code Climate
#
if ENV['GITHUB_ACTIONS'] && RUBY_ENGINE == 'ruby' && RUBY_VERSION.start_with?(ENV['COVERAGE_RUBY_VERSION'] || 'x')
  require 'simplecov'
  SimpleCov.start
end

##
# Load Rspec supporting files
#
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

# Load App files
Dir['./app/*.rb'].sort.each { |f| require f }

# require File.expand_path("app/**/*.rb", __FILE__)

##
# Detect Rails/Sinatra dummy application based on gemfile name substituted by Appraisal
#
if ENV['APPRAISAL_INITIALIZED'] || ENV['GITHUB_ACTIONS']
  app_name = Pathname.new(ENV['BUNDLE_GEMFILE']).basename.sub('.gemfile', '')
else
  /.*?(?<app_name>rails.*?)\.gemfile/ =~ Dir['gemfiles/rails*.gemfile'].max
end

##
# Load dummy application and Rspec
#
app_framework = %w[rails sinatra].find { |f| app_name.to_s.include?(f) }

case app_framework
when 'rails'
  # Load Rails
  require File.expand_path("../app/#{app_name}/config/environment", __FILE__)

  APP_RAKEFILE = File.expand_path("../app/#{app_name}/Rakefile", __FILE__)

  # Load Rspec
  require 'rspec/rails'

  # Configure
  RSpec.configure do |config|
    config.fixture_path = FixtureHelper::FIXTURE_PATH
  end

when 'sinatra'
  # Load Sinatra
  require File.expand_path("../app/#{app_name}/app", __FILE__)

  # Load Rspec
  require 'rspec'

  # Configure
  RSpec.configure do |config|
    config.filter_run_excluding :rails
    config.include FixtureHelper
  end
end

##
# Print some debug info
#
puts
puts "Gemfile: #{ENV['BUNDLE_GEMFILE']}"
puts 'Version:'

Gem.loaded_specs.each do |name, spec|
  puts "\t#{name}-#{spec.version}" if %w[rails activerecord-jdbcsqlite3-adapter sqlite3 rspec-rails
                                         sinatra].include?(name)
end

puts
