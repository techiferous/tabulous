RSpec::Matchers.define :be_same_text_as do |expected|
  match do |actual|
    # remove trailing whitespace as it doesn't matter for the purposes of diffing
    expected = expected.map(&:rstrip)
    actual = actual.map(&:rstrip)
    # now make one big string out of the array of strings
    expected = expected.join("\n")
    actual = actual.join("\n")
    message = Diffy::Diff.new(expected, actual).to_s(:color)
    expected == actual
  end
end
