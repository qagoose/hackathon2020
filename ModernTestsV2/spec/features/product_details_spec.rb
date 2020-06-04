require_relative '../helpers/index_helpers'
require_relative '../../spec/helpers/goggles'

RSpec.describe 'Product details' do
  include IndexHelpers
  it 'shows product details' do

    Goggles.protect(test_name: "Task 3", eyes: @eyes, webdriver: @driver) do
      set_filters filters: %w[Black]
      click_shoe 'Appli Air x Night'
      @eyes.check('Product Details Test', Applitools::Selenium::Target.window.fully)
    end

  end
end