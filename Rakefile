begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :clear_file do
    file = File.open('./recipe_data.yml', 'w')
    file.write('')
    file.close
  end
  task default: [:spec, :clear_file]
rescue LoadError
  # rspec not available
end