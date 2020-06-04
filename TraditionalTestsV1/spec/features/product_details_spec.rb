require_relative '../helpers/index_helpers'
require_relative '../helpers/test_log_helper'
require_relative '../support/matchers/product_details_matchers'
require_relative '../helpers/helpers'
require_relative '../support/shared_examples/shared_examples_for_product_details'

RSpec.describe 'Product details' do
  include TestLogHelper
  include IndexHelpers
  include GenericHelpers

  after(:each) do |example|
    status = example.exception.nil? ? 'Pass' : 'Fail'
    dimensions = @driver.manage.window.size

    log_test_result(file: 'Traditional-V1-TestResults.txt',
                    task: 3,
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

    include_examples 'Product Details', :laptop
  end

  context 'at tablet size' do
    before(:all) do
      set_screen_details(:tablet, 'Tablet')
    end

    include_examples 'Product Details', :tablet
  end

  context 'at mobile size' do
    before(:all) do
      set_screen_details(:mobile, 'Mobile')
    end

    include_examples 'Product Details', :mobile
  end
end

