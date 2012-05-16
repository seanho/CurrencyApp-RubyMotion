$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  app.name = 'Currency'
  app.files += Dir.glob(File.join(app.project_dir, 'vendor/SimpleView/lib/**/*.rb'))
  app.files_dependencies 'vendor/SimpleView/lib/builders/ui_activity_indicator_view_builder.rb' => 'vendor/SimpleView/lib/builders/ui_view_builder.rb'
  app.files_dependencies 'vendor/SimpleView/lib/builders/ui_control_builder.rb' => 'vendor/SimpleView/lib/builders/ui_view_builder.rb'
  app.files_dependencies 'vendor/SimpleView/lib/builders/ui_button_builder.rb' => 'vendor/SimpleView/lib/builders/ui_control_builder.rb'
end
