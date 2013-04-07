module Tabulous
  class << self
    def setup(&block)
      Dsl::Setup.process(&block)
    end
  end
end
