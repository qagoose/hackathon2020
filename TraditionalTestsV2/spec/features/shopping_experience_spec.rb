require_relative '../support/shared_examples/shared_examples_for_shopping_experience'
require_relative '../helpers/index_helpers'
require_relative '../support/matchers/index_matchers'
require_relative '../helpers/test_log_helper'
require_relative '../helpers/helpers'

RSpec.describe 'Shopping experience' do
  include TestLogHelper
  include IndexHelpers
  include IndexMatchers
  include GenericHelpers

  after(:each) do |example|
    status = example.exception.nil? ? 'Pass' : 'Fail'
    dimensions = @driver.manage.window.size

    log_test_result(file: 'Traditional-V2-TestResults.txt',
                    task: 2,
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

    include_examples 'Shopping Experience', :laptop
  end

  context 'at tablet size' do
    before(:all) do
      set_screen_details(:tablet, 'Tablet')
    end

    include_examples 'Shopping Experience', :tablet
  end

  context 'at mobile size' do
    before(:all) do
      set_screen_details(:mobile, 'Mobile')
    end

    include_examples 'Shopping Experience', :mobile
  end


  end

