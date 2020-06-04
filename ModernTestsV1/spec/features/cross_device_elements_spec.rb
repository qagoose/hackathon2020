require_relative '../helpers/goggles'

RSpec.describe 'Cross device elements' do
  it 'should display elements correctly at each screen size' do
    Goggles.protect(test_name: 'Task 1', eyes: @eyes, webdriver: @driver) do
      @eyes.check('Cross device elements', Applitools::Selenium::Target.window.fully)
    end
  end
end



