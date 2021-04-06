 
require 'rails_helper'

RSpec.feature "Visitor adds item to the cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "The counter increases by 1 for the cart" do
    # ACT
    visit root_path
    expect(page).to have_content('My Cart (0)')
    first(:button, "Add").click
    save_screenshot

    # DEBUG 
    expect(page).to have_text 'My Cart (1)'
    save_screenshot
  end

end 