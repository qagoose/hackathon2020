require_relative '../../helpers/index_helpers'

RSpec.shared_examples "Cross Device Elements" do |size|
  include IndexHelpers

  it 'shows the filters' do
    open_tablet_filters if size == :tablet
    open_mobile_filters if size == :mobile

    expect(@page).to show_filters title: 'type', items: %w[Soccer Basketball Running Training]
    expect(@page).to show_filters title: 'colors', items: %w[Black White Blue Green Yellow]
    expect(@page).to show_filters title: 'brands', items: %w[Adibas Mykey Bans Over\ Armour ImBalance]
  end

  it 'shows the banner image' do
    expect(@page).to show_banner '/grid/img/bg_cat_shoes.jpg'
  end

  it 'shows the filter button' do
    open_tablet_filters if size == :tablet
    open_mobile_filters if size == :mobile

    expect(@page).to show_filter_button
  end

  it 'shows the reset button' do
    open_tablet_filters if size == :tablet
    open_mobile_filters if size == :mobile

    expect(@page).to show_reset_button
  end

  it 'shows a shoe with discount' do
    expect(@page).to have_sellable_item name: 'Appli Air x Night',
                                        current_price: 33.00,
                                        old_price: 48.00,
                                        discount: 30,
                                        days_left: 1
  end

  it 'shows a shoe without a discount' do
    expect(@page).to have_sellable_item name: 'Appli ACG React Terra',
                                        current_price: 110.00
  end
end