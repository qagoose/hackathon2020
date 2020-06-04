require_relative '../helpers/index_helpers'
require_relative '../helpers/goggles'

RSpec.describe 'Shopping experience' do
  include IndexHelpers

  it 'filters shoes to find black ones' do
    Goggles.protect test_name: 'Task 2', eyes: @eyes, webdriver: @driver do
      set_filters filters: %w[Black]
      @eyes.check('Filter Results', Applitools::Selenium::Target.region(id: 'product_grid'))
    end
  end
end

