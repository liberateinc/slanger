require 'rspec/core/rake_task'
require "bundler/gem_tasks"
require 'bundler/audit/task'

desc 'Default: run specs.'
task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = "--order default"
end

desc 'Audit: check for vulnerabilities'
task audit: 'bundle:audit'

Bundler::Audit::Task.new
