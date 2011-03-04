namespace :tabs do
  desc "Prettify app/tabs/tabulous.rb"
  task :format do
    require File.expand_path('../tabulous/formatter', File.dirname(__FILE__))
    filename = File.join(Rails.root.to_s, 'app', 'tabs', 'tabulous.rb')
    reformatted = Tabulous::Formatter.format(IO.readlines(filename))
    File.open(filename, 'w') do |f|
      f.puts reformatted
    end
  end
end
