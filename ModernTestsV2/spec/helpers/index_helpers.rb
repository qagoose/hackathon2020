module IndexHelpers
  def set_filters(filters:)
    @driver.find_element(xpath: "//span[text()='Filters']").click

    filters.each do |filter|
      filterEle = @driver.find_element(xpath: "//label[contains(text(), '#{filter}')]")
      Selenium::WebDriver::Wait.new(timeout: 3).until { filterEle.displayed? }
      filterEle.click
    end

    @driver.find_element(id: 'filterBtn').click
  end

  def click_shoe(name)
    @driver.find_element(xpath: "//h3[text()='#{name}']").click
  end
end