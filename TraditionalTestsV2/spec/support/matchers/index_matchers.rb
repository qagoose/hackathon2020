module IndexMatchers
  RSpec::Matchers.define :show_filters do |title:, items:|
    items_not_found = []

    match do |driver|
      filter_section = driver.find_element(xpath: "//a[contains(text(), '#{title}')]/../..")

      Selenium::WebDriver::Wait.new(timeout: 3).until { filter_section.displayed? }

      items.each do |filter_item|
        begin
          filter_section.find_element(xpath: ".//label[contains(text(), '#{filter_item}')]")
        rescue Selenium::WebDriver::Error::NoSuchElementError
          items_not_found << filter_item
        end
      end

      items_not_found.empty?
    end

    failure_message do |page|
      "expected that page would show filter items #{items_not_found.to_s}"
    end
  end

  RSpec::Matchers.define :show_banner do |img_url|
    match do |driver|
      banner = driver.find_element(id: 'DIV__topbanner__188')
      banner.css_value('background-image').include? img_url
    end
  end

  # Don't look at this
  RSpec::Matchers.define :have_sellable_item do |name:, current_price:, old_price: false, discount: false, days_left: false|
    results = { name: false, discount: false, days_left: false, current_price: false, old_price: false }

    match do |driver|
      all_passed = true

      grid = driver.find_element(id: 'product_grid')
      grid_item = grid.find_element(xpath: ".//h3[text()='#{name}']/../../..")

      results[:name] = true

      # Find current price
      actual_current_price = grid_item.find_element(class: 'new_price').text

      # Figure out if a discount % has been applied
      begin
        actual_discount = grid_item.find_element(class: 'ribbon').text
      rescue Selenium::WebDriver::Error::NoSuchElementError
        actual_discount = false
      end

      # Figure out if an old price is being show
      begin
        actual_old_price = grid_item.find_element(class: 'old_price').text
      rescue Selenium::WebDriver::Error::NoSuchElementError
        actual_old_price = false
      end

      begin
        actual_days_left = grid_item.find_element(class: 'countdown').text
      rescue Selenium::WebDriver::Error::NoSuchElementError
        actual_days_left = false
      end

      current_price = sprintf("%.2f", current_price)

      results[:current_price] = true if actual_current_price == "$#{current_price}"

      if old_price != false
        old_price = sprintf("%.2f", old_price)
        results[:old_price] = true if actual_old_price == "$#{old_price}"
      else
        results[:old_price] = true unless old_price
      end

      if discount != false
        results[:discount] = true if actual_discount == "-#{discount}%"
      else
        results[:discount] = true unless actual_discount
      end

      if days_left != false
        if actual_days_left == "#{days_left} day left"
          results[:days_left] = true
        end
      else
        results[:days_left] = true unless actual_days_left
      end

      results.each do |key, value|
        all_passed = false if value == false
      end

      all_passed
    end

    failure_message do |page|
      "page did not have sellable item, the following did not match: #{results}"
    end
  end

  RSpec::Matchers.define :show_filter_button do
    match do |driver|
      filterBtn = driver.find_element(id: 'filterBtn')
      Selenium::WebDriver::Wait.new(timeout: 3).until { filterBtn.displayed? }

      filterBtn.displayed?
    end
  end

  RSpec::Matchers.define :show_reset_button do
    match do |driver|
      resetBtn = driver.find_element(id: 'resetBtn')
      Selenium::WebDriver::Wait.new(timeout: 3).until { resetBtn.displayed? }

      resetBtn.displayed?
    end
  end

  RSpec::Matchers.define :show_search_bar do
    match do |driver|
      driver.find_element(xpath: "//div[@class='custom-search-input']/input").displayed?
    end
  end

  RSpec::Matchers.define :have_quick_links do |links:, expanded:|
    found_links = []

    match do |driver|
      container = driver.find_element(xpath: "//h3[text()='Quick Links']/..")

      links.each do |link|
        link_element = container.find_element(xpath: ".//a[text()='#{link}']")

        if expanded
          found_links << link if link_element.displayed?
        else
          found_links << link unless link_element.displayed?
        end
      end

      found_links.length == links.length
    end
  end

  RSpec::Matchers.define :have_contacts do |contacts:, expanded:|
    located_contacts = []

    match do |driver|
      container = driver.find_element(xpath: "//h3[text()='Contacts']/..")

      contacts.each do |contact|
        contact_element = container.find_element(xpath: ".//li[contains(.,'#{contact}')]")

        if expanded
          located_contacts << contact_element if contact_element.displayed?
        else
          located_contacts << contact_element unless contact_element.displayed?
        end
      end

      located_contacts.length == contacts.length
    end
  end

  RSpec::Matchers.define :have_keep_in_touch do |expanded:|
    found = false

    match do |driver|
      container = driver.find_element(xpath: "//h3[text()='Keep in touch']/..")
      newsletter_input = container.find_element(id: 'email_newsletter')

      if expanded
        found = true if newsletter_input.displayed?
      else
        found = true unless newsletter_input.displayed?
      end
    end

    found
  end

  RSpec::Matchers.define :show_search_expansion_button do
    match do |driver|
      driver.find_element(id: 'A__btnsearchm__59').displayed?
    end
  end

  RSpec::Matchers.define :show_grid_options do
    match do |driver|
      driver.find_element(class: 'ti-view-grid').displayed? && driver.find_element(class: 'ti-view-list').displayed?
    end
  end

  RSpec::Matchers.define :show_product_heart do
    match do |driver|
      driver.find_element(xpath: "//a[@data-original-title='Add to favorites']").displayed?
    end
  end

  RSpec::Matchers.define :show_product_compare do
    match do |driver|
      driver.find_element(xpath: "//a[@data-original-title='Add to compare']").displayed?
    end
  end

  RSpec::Matchers.define :show_add_product_to_cart do
    match do |driver|
      driver.find_element(xpath: "//a[@data-original-title='Add to cart']").displayed?
    end
  end

  RSpec::Matchers.define :show_menu_category_link do |category|
    match do |driver|
      # 'link' how fails to locate these when they're not displayed, so going with xpath
      driver.find_element(xpath: "//a[text()='#{category}']").displayed?
    end
  end
end
