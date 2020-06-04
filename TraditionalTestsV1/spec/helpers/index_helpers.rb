module IndexHelpers
  def set_filters(filters:)
    filters.each do |filter|
      filterEle = @driver.find_element(xpath: "//label[contains(text(), '#{filter}')]")
      Selenium::WebDriver::Wait.new(timeout: 3).until { filterEle.displayed? }
      filterEle.click
    end

    @driver.find_element(id: 'filterBtn').click
  end

  def get_number_of_shoes
    @driver.find_elements(class: 'grid_item').length
  end

  def click_shoe(name)
    @driver.find_element(xpath: "//h3[text()='#{name}']").click
  end

  def open_tablet_filters
    @driver.find_element(xpath: "//span[text()='Filters']").click
  end

  def open_mobile_filters
    @driver.find_elements(class: 'open_filters').last.click
  end
end