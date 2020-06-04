require_relative '../support/shared_examples/shared_examples_for_cross_device_elements'
require_relative '../support/matchers/index_matchers'
require_relative '../helpers/test_log_helper'
require_relative '../helpers/helpers'

RSpec.describe 'Cross device elements' do
  include IndexMatchers
  include TestLogHelper
  include GenericHelpers

  after(:each) do |example|
    status = example.exception.nil? ? 'Pass' : 'Fail'
    dimensions = @driver.manage.window.size

    log_test_result(file: 'Traditional-V2-TestResults.txt',
                    task: 1,
                    test_name: example.metadata[:full_description],
                    browser_name: @browser.to_s,
                    browser_viewport: { height: dimensions.height, width: dimensions.width },
                    device: @device_name,
                    status: status)
  end

  context 'at laptop size' do
    before(:all) do
      set_screen_details(:laptop, 'Laptop')
    end

    include_examples 'Cross Device Elements'

    it 'shows the search bar' do
      expect(@page).to show_search_bar
    end

    it 'expands the footer links' do
      expect(@page).to have_quick_links links: %w[About\ us Faq Help My\ account Blog Contacts], expanded: true
      expect(@page).to have_contacts contacts: ['155 Bovet Rd #600', 'San Mateo, CA 94402', 'srd@applitools.com'], expanded: true
      expect(@page).to have_keep_in_touch expanded: true
    end

    it 'does not show the search expansion button' do
      expect(@page).to_not show_search_expansion_button
    end

    it 'shows the grid options' do
      expect(@page).to show_grid_options
    end

    it 'does not show product options' do
      expect(@page).to_not show_product_heart
      expect(@page).to_not show_product_compare
      expect(@page).to_not show_add_product_to_cart
    end

    it 'shows menu categories' do
      expect(@page).to show_menu_category_link 'HOME'
      expect(@page).to show_menu_category_link 'MEN'
      expect(@page).to show_menu_category_link 'WOMEN'
      expect(@page).to show_menu_category_link 'RUNNING'
      expect(@page).to show_menu_category_link 'TRAINING'
    end

    it 'hides the filter text' do
      expect(@page).to_not show_filter_text
    end

    it 'hides the filter icon' do
      expect(@page).to_not show_filter_icon
    end
  end

  context 'at tablet size' do
    before(:all) do
      set_screen_details(:tablet, 'Tablet')
    end

    include_examples 'Cross Device Elements', :tablet

    it 'shows the search bar' do
      expect(@page).to show_search_bar
    end

    it 'expands the footer links' do
      expect(@page).to have_quick_links links: %w[About\ us Faq Help My\ account Blog Contacts], expanded: true
      expect(@page).to have_contacts contacts: ['155 Bovet Rd #600', 'San Mateo, CA 94402', 'srd@applitools.com'], expanded: true
      expect(@page).to have_keep_in_touch expanded: true
    end

    it 'shows the filter text' do
      expect(@page).to show_filter_text
    end

    it 'shows the filter icon' do
      expect(@page).to show_filter_icon
    end

    it 'does not show the search expansion button' do
      expect(@page).to_not show_search_expansion_button
    end

    it 'does not show the grid options' do
      expect(@page).to_not show_grid_options
    end

    it 'shows product options' do
      expect(@page).to show_product_heart
      expect(@page).to show_product_compare
      expect(@page).to show_add_product_to_cart
    end

    it 'does not show menu categories' do
      expect(@page).to_not show_menu_category_link 'HOME'
      expect(@page).to_not show_menu_category_link 'MEN'
      expect(@page).to_not show_menu_category_link 'WOMEN'
      expect(@page).to_not show_menu_category_link 'RUNNING'
      expect(@page).to_not show_menu_category_link 'TRAINING'
    end

    it 'does not show the heart icon in the header' do
      expect(@page).to_not show_header_heart
    end


  end

  context 'at mobile size' do
    before(:all) do
      set_screen_details(:mobile, 'Mobile')
    end

    include_examples 'Cross Device Elements', :mobile

    it 'hides the search bar' do
      expect(@page).not_to show_search_bar
    end

    it 'shows the search expansion button' do
      expect(@page).to show_search_expansion_button
    end

    it 'collapses the footer links' do
      expect(@page).to have_quick_links links: %w[About\ us Faq Help My\ account Blog Contacts], expanded: false
      expect(@page).to have_contacts contacts: ['155 Bovet Rd #600', 'San Mateo, CA 94402', 'srd@applitools.com'], expanded: false
      expect(@page).to have_keep_in_touch expanded: false
    end

    it 'does not show the grid options' do
      expect(@page).to_not show_grid_options
    end

    it 'shows product options' do
      expect(@page).to show_product_heart
      expect(@page).to show_product_compare
      expect(@page).to show_add_product_to_cart
    end

    it 'does not show menu categories' do
      expect(@page).to_not show_menu_category_link 'HOME'
      expect(@page).to_not show_menu_category_link 'MEN'
      expect(@page).to_not show_menu_category_link 'WOMEN'
      expect(@page).to_not show_menu_category_link 'RUNNING'
      expect(@page).to_not show_menu_category_link 'TRAINING'
    end

    it 'hides the filter text' do
      expect(@page).to_not show_filter_text
    end

    it 'shows the filter icon' do
      expect(@page).to show_filter_icon
    end
  end
end
