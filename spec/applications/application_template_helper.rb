#**************************************************************************************#
#   Refer to spec/applications/README for a full understanding of test applications.   #
#**************************************************************************************#

require File.expand_path('../universal_gemfile', __FILE__)

# convenience method to save typing
def replace_view(controller_name, action_name, view_code)
  file_name = "app/views/#{controller_name}/#{action_name}.html.erb"
  remove_file file_name
  add_file file_name, view_code
end

# convenience method to save typing
def replace_application_layout(code)
  remove_file 'app/views/layouts/application.html.erb'
  add_file 'app/views/layouts/application.html.erb', code
end

def rails_version?(ver)
  ENV['TEST_APP_RAILS_VERSION'] =~ %r{^#{ver}}
end

# returns the full path of the application that's being generated
def app_dir
  val = nil
  inside do
    val = File.expand_path(Dir.pwd, __FILE__)
  end
  val
end

# copy all of the files and directories in spec/applications/universal into the new Rails application
def copy_universal
  Dir.glob(File.join(File.expand_path('../universal', __FILE__), '**', '*')) do |path|
    shortened_path = path.match(/universal\/(.+)/)[1]
    if File.directory?(path)
      run "mkdir -p #{app_dir}/#{shortened_path}"
    else
      run "cp #{path} #{app_dir}/#{shortened_path}"
    end
  end
end

# copy all of the files and directories in spec/applications/[app_name]/shared into the new Rails application
def copy_shared
  Dir.glob(File.join(app_dir, '..', 'shared', '**', '*')) do |path|
    shortened_path = path.match(/shared\/(.+)/)[1]
    if File.directory?(path)
      run "mkdir -p #{app_dir}/#{shortened_path}"
    else
      run "cp #{path} #{app_dir}/#{shortened_path}"
    end
  end
end

def remove_test_files
  inside do
    run "rm -rf spec/controllers"
    run "rm -rf spec/helpers"
    run "rm -rf spec/models"
    run "rm -rf spec/requests"
    run "rm -rf spec/routing"
    run "rm -rf spec/views"
    run "rm -rf test/performance"
  end
end

def use_the_right_gemfile
  # Bundler wants to use tabulous's Gemfile instead of the Gemfile belonging
  # to the new Rails app.  So we need to explicitly set the environment
  # variable so that Bundler uses the right Gemfile.
  # For more details: http://spectator.in/2011/01/28/bundler-in-subshells/
  ENV['BUNDLE_GEMFILE'] = File.join(app_dir, 'Gemfile')
end

def make_adjustments_per_rails_version
  if rails_version? '3.1'
    gsub_file 'config/environments/development.rb', 'config.active_record.mass_assignment_sanitizer', '# config.active_record.mass_assignment_sanitizer'
    gsub_file 'config/environments/development.rb', 'config.active_record.auto_explain_threshold_in_seconds', '# config.active_record.auto_explain_threshold_in_seconds'
    gsub_file 'config/environments/test.rb', 'config.active_record.mass_assignment_sanitizer', '# config.active_record.mass_assignment_sanitizer'
    gsub_file 'config/environments/test.rb', 'config.active_record.auto_explain_threshold_in_seconds', '# config.active_record.auto_explain_threshold_in_seconds'
  end
end

# All of the test applications share boilerplate code and behavior.  Instead
# of having this repeated in each test application's application template,
# the common behavior is found here.
#
# This means that when you create a new kind of test application, don't
# write your application template from scratch, but wrap it in a call to
# generate_test_application so that you can be sure to get the shared
# behavior.
def generate_test_application
  use_the_right_gemfile
  add_gems
  make_adjustments_per_rails_version
  yield
  remove_file 'public/index.html'
  remove_test_files
  copy_universal
  copy_shared
  rake 'db:migrate'
  rake 'db:test:prepare'
end
