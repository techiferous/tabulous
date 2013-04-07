module Tabulous
  require 'tabulous/railtie' if defined?(Rails)
end

require 'tabulous/errors'
require 'tabulous/old_version_checker'
require 'tabulous/tabsets'
require 'tabulous/view_helpers'
require 'tabulous/css_scaffolding'
require 'tabulous/config'
require 'tabulous/tab'
require 'tabulous/tabset'
require 'tabulous/dsl/config'
require 'tabulous/dsl/tab'
require 'tabulous/dsl/tabs'
require 'tabulous/dsl/setup'
require 'tabulous/rendering_coordinator'
require 'tabulous/renderers/split_renderer'
require 'tabulous/renderers/combined_renderer'
require 'tabulous/renderers/default_renderer'
require 'tabulous/renderers/html5_renderer'
require 'tabulous/renderers/bootstrap_renderer'
require 'tabulous/renderers/bootstrap_pill_renderer'
require 'tabulous/tabulous'
