namespace :tabs do
  desc "Prettify config/initializers/tabulous.rb"
  task :format do
    require File.expand_path('../tabulous/tabulous_formatter', File.dirname(__FILE__))
    filename = File.join(Rails.root.to_s, 'config', 'initializers', 'tabulous.rb')
    reformatted = Tabulous::Formatter.format(IO.readlines(filename))
    File.open(filename, 'w') do |f|
      f.puts reformatted
    end
  end
end
