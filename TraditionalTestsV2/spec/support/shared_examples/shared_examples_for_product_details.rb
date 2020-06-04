require_relative '../../helpers/index_helpers'

RSpec.shared_examples "Product Details" do |size|
  include IndexHelpers

  it 'shows product details' do
    open_tablet_filters if size == :tablet
    open_mobile_filters if size == :mobile

    set_filters filters: %w[Black]

    click_shoe 'Appli Air x Night'

    expect(@page).to have_css_property element_how: 'id', element_what: 'old_price', css_property: 'text-decoration', property_value: 'line-through'
    expect(@page).to have_css_property element_how: 'id', element_what: 'old_price', css_property: 'color', property_value: '#999'
    expect(@page).to have_header 'Appli Air x Night'
    expect(@page).to have_shoe_image 'grid/img/products/shoes/1.jpg'
    expect(@page).to have_sku 'MTKRY-001'
    expect(@page).to have_star_rating 4
    expect(@page).to have_number_of_reviews 4
    expect(@page).to have_description locator: 'These boots are comfortable',
                                      description: 'These boots are comfortable enough to wear all day. Well made. '\
                                      'I love the “look”. Best Used For Casual Everyday Walk fearlessly '\
                                      'into the cooler months in the Sorel Joan Of Arctic Wedge II Chelsea '\
                                      'Boot. Boasting the iconic wedge platform that\'s as comfortable as it is '\
                                      'stylish, this boot features a waterproof upper'
    expect(@page).to have_selected_size 'Small (S)'
    expect(@page).to have_selected_quantity 1
    expect(@page).to have_current_price '$33.00'
    expect(@page).to have_old_price '$48.00'
    expect(@page).to have_discount '-30%'
  end
end