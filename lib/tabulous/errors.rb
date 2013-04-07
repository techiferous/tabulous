module Tabulous

  class TabulousError < StandardError
    def initialize(msg=nil)
      msg = "Tabulous Error: #{msg}"
      super
    end
  end

  class SubtabOutOfOrderError < TabulousError; end
  class MissingDeclarationError < TabulousError; end
  class UnknownDeclarationError < TabulousError; end
  class TabNameError < TabulousError; end
  class NoTabFoundError < TabulousError; end
  class MissingActiveTabRuleError < TabulousError; end
  class AmbiguousActiveTabRulesError < TabulousError; end
  class ImproperValueError < TabulousError; end
  class OldVersionError < TabulousError; end
  class SubtabsHelperNotApplicable < TabulousError; end

end
