require "rails_helper"

RSpec.feature "Policy Prices" do
  scenario "Traveler enters their date of birth and length of trip" do
    visit "/policy_prices/new"

    fill_in "Date of Birth", with: "1976-11-01"
    fill_in "Length of Trip", with: "8"

    click_button "Get Travel Policy Price"

    expect(page).to have_text("Your Travel Insurance price is $60.")
  end

  scenario "Traveler enters invalid date of birth and can correct and get a price" do
    visit "/policy_prices/new"

    fill_in "Date of Birth", with: "2013-01-11"
    fill_in "Length of Trip", with: "8"

    click_button "Get Travel Policy Price"

    expect(page).to have_text("We were unable to calculate the travel insurance price due to")

    fill_in "Date of Birth", with: "1976-11-01"

    click_button "Get Travel Policy Price"

    expect(page).to have_text("Your Travel Insurance price is $60.")
  end

  scenario "Traveler enters invalid length of trip and can correct and get a price" do
    visit "/policy_prices/new"

    fill_in "Date of Birth", with: "1976-11-01"
    fill_in "Length of Trip", with: "2.5"

    click_button "Get Travel Policy Price"

    expect(page).to have_text("We were unable to calculate the travel insurance price due to")

    fill_in "Length of Trip", with: "8"
    
    click_button "Get Travel Policy Price"
    
    expect(page).to have_text("Your Travel Insurance price is $60.")
  end
end