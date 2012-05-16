$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  app.name = 'Currency'
  app.files += Dir.glob(File.join(app.project_dir, 'vendor/SimpleView/lib/**/*.rb'))
end
