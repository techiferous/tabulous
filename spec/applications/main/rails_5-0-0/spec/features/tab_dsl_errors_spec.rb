require 'spec_helper'

describe 'tab DSL' do
  include TabHelpers

  context 'missing text' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end
          end
        end
      }
    }
    it "should raise an error" do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::MissingDeclarationError)
    end
  end

  context 'missing link_path' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          'Explanation'
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end
          end
        end
      }
    }
    it "should raise an error" do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::MissingDeclarationError)
    end
  end

  context 'missing visible_when' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          'Explanation'
              link_path     { root_path }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end
          end
        end
      }
    }
    it "should raise an error" do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::MissingDeclarationError)
    end
  end

  context 'missing enabled_when' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          'Explanation'
              link_path     { root_path }
              visible_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end
          end
        end
      }
    }
    it "should raise an error" do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::MissingDeclarationError)
    end
  end

  context 'missing active_when' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          'Explanation'
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
            end
          end
        end
      }
    }
    it "should raise an error" do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::MissingDeclarationError)
    end
  end

  context 'unknown declaration' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          'Explanation'
              link_path     { root_path }
              not_known
              visible_when  { true }
              enabled_when  { true }
            end
          end
        end
      }
    }
    it "should raise an error" do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::UnknownDeclarationError)
    end
  end

  context 'text that is not a string' do
    before(:each) do
      use_tab_file %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          :foo
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end
          end
        end
      }
    end
    it "should raise an error" do
      expect { visit '/' }.to raise_error(ActionView::Template::Error)
    end
  end

  context 'link_path that is not a string' do
    before(:each) do
      use_tab_file %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          'Explanation'
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end

            galaxies_tab do
              text          'Galaxies'
              link_path     Math::PI
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('planets') }
            end
          end
        end
      }
    end
    it "should raise an error" do
      expect { visit '/' }.to raise_error(ActionView::Template::Error)
    end
  end

end
