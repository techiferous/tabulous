module Tabulous
  class OldVersionChecker

    # The old version of the tabulous.rb file starts like this:
    #
    #   Tabulous.setup do |config|
    #
    # The new version starts like this:
    #
    #   Tabulous.setup do
    #
    # This class is a dummy class that will intercept any methods sent to
    # the config object if the tabulous.rb file is using the old format.
    #
    def method_missing(meth, *args, &block)
      msg = "It looks like your tabulous.rb file is written for an "
      msg << "old version of tabulous. This newer version of tabulous "
      msg << "uses a new syntax that is not backwards-compatible."
      raise OldVersionError, msg
    end

  end
end