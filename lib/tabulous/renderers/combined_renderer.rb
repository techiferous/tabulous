# A "combined" renderer is one that renders subtab HTML directly inside the
# HTML list of tabs, rather than two separate HTML lists for tabs and subtabs.
#
# This class is meant to be subclassed.  It encapsulates the code
# common to all combined renderers so that it doesn't have to be recoded
# everytime.

module Tabulous
  class CombinedRenderer < BaseRenderer

    def subtabs_html
      msg = "You have called the subtabs view helper. "
      msg << "However, the renderer that you've chosen does not support "
      msg << "this view helper, since this renderer renders subtabs when "
      msg << "the tabs helper is called. Simply remove the call to "
      msg << "subtabs to fix this error."
      raise SubtabsHelperNotApplicable, msg
    end

  end
end
