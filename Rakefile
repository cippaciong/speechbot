# file: Rakefile
require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs << %w(test lib)
  task.pattern = 'test/*_test.rb'
  task.warning = false
end

task :default => :test
