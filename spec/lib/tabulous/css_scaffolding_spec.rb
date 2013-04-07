require_relative '../../spec_helper'

describe Tabulous::CssScaffolding do
  describe "embeddable styles" do
    let(:embeddable_styles) { Tabulous::CssScaffolding.embeddable_styles }

    it "should be a string" do
      embeddable_styles.should be_a(String)
    end

    it "should be embeddable in HTML" do
      expect(embeddable_styles).to match(/^\s*<style type="text\/css">/)
      expect(embeddable_styles).to match(/<\/style>\s*$/)
    end

    it "should have tab-related CSS" do
      expect(embeddable_styles).to match(/.tabs ul/)
      expect(embeddable_styles).to match(/.subtabs ul/)
    end
  end
end
