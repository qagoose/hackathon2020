module ProductDetailsMatchers

RSpec::Matchers.define :have_header do |shoe_name|
  match do |driver|
    header = driver.find_element(id: 'shoe_name')
    header.text == shoe_name && header.displayed?
  end
end

RSpec::Matchers.define :have_shoe_image do |image|
  match do |driver|
    shoe_image = driver.find_element(:id, 'shoe_img')
    shoe_image.css_value('background-image').include?(image) && shoe_image.displayed?
  end
end

RSpec::Matchers.define :have_sku do |sku|
  match do |driver|
    driver.find_element(xpath: "//*[text()='SKU: #{sku}']").displayed?
  end
end

RSpec::Matchers.define :have_star_rating do |number_of_stars|
  match do |driver|
    filled_stars = driver.find_elements(xpath: "//*[@class='icon-star voted']")
    empty_stars = driver.find_elements(xpath: "//*[@class='icon-star']")

    filled_stars.length == number_of_stars && empty_stars.length == 5 - number_of_stars
  end
end

RSpec::Matchers.define :have_number_of_reviews do |number_of_reviews|
  match do |driver|
    driver.find_element(xpath: "//*[text()='#{number_of_reviews} reviews']").displayed?
  end
end

RSpec::Matchers.define :have_description do |locator:, description:|
  match do |driver|
    actual_description = driver.find_element(xpath: "//p[contains(text(), '#{locator}')]")
    puts description
    puts actual_description.text
    actual_description.text.include?(description) && actual_description.displayed?
  end
end

RSpec::Matchers.define :have_selected_size do |size|
  match do |driver|
    selected_size = driver.find_element(class: 'current')

    selected_size.text == size && selected_size.displayed?
  end
end

RSpec::Matchers.define :have_selected_quantity do |quantity|
  match do |driver|
    actual_quantity = driver.find_element(id: 'quantity_1')

    actual_quantity.attribute('value') == quantity.to_s && actual_quantity.displayed?
  end
end

RSpec::Matchers.define :have_current_price do |price|
  match do |driver|
    actual_price = driver.find_element(id: 'new_price')

    actual_price.text == price && actual_price.displayed?
  end
end

RSpec::Matchers.define :have_old_price do |price|
  match do |driver|
    actual_price = driver.find_element(id: 'old_price')

    actual_price.text == price && actual_price.displayed?
  end
end

RSpec::Matchers.define :have_discount do |discount|
  match do |driver|
    actual_discount = driver.find_element(id: 'discount')

    actual_discount.text == (discount + " discount") && actual_discount.displayed?
  end
end

end