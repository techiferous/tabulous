# In a Rails 3.0 only environment, there is no strip_heredoc.  It's nice to
# have, so we make sure it's available anyway.
if !"string".respond_to? :strip_heredoc
  class String
    def strip_heredoc
      min = scan(/^[ \t]*(?=\S)/).min
      indent = min ? min.size : 0
      gsub(/^[ \t]{#{indent}}/, '')
    end
  end
end
