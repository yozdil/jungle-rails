require 'rails_helper'

RSpec.feature "Existing user can login", type: :feature, js: true do
  
    # SETUP 
    before :each do 
      @user = User.create!(
        first_name: 'Yamac',
        last_name: 'Ozdil',
        email: 'yamac.ozdil@hey.com',
        password: 'test123',
        password_confirmation: 'test123'
      )
    end

    scenario "After logging in existing user gets a message Logged in as on the navbar" do
    # ACT
    visit root_path

    # VERIFY
    find_link('Login').click

    expect(page).to have_content('Email')
    expect(page).to have_content('Password')

    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password

    find_button('Submit').click

    
    expect(page).to have_content('Signed in as ' + @user.first_name)
    
    # DEBUG 
    save_screenshot
    
  end

end
