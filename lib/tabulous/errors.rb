module Tabulous

  class TabulousError < StandardError
    def initialize(msg=nil)
      msg = "Tabulous Error: #{msg}"
      super
    end
  end

  class ColumnError < TabulousError; end

end
