require_relative '../../helpers/index_helpers'

RSpec.shared_examples "Shopping Experience" do |size|
  include IndexHelpers

  it 'filters shoes to find black ones' do
    open_tablet_filters if size == :tablet
    open_mobile_filters if size == :mobile

    # Initial check to make sure the filter ends up doing something
    expect(get_number_of_shoes > 2).to be true

    set_filters filters: %w[Black]
    expect(get_number_of_shoes).to eq 2

    expect(@page).to have_sellable_item name: "Appli Air x Night",
                                        current_price: 33.00,
                                        old_price: 48.00,
                                        discount: 30,
                                        days_left: 1

    expect(@page).to have_sellable_item name: "Appli Air 720", current_price: "200.00"
  end
end