require "rails_helper"

RSpec.feature "Policy Prices" do
  scenario "Traveler enters their age and length of trip" do
    visit "/policy_prices/new"

    fill_in "Age", with: "40"
    fill_in "Length of Trip", with: "8"

    click_button "Get Travel Policy Price"

    expect(page).to have_text("Your Travel Insurance price is $60.")
  end

  scenario "Traveler enters invalid age and can correct and get a price" do
    visit "/policy_prices/new"

    fill_in "Age", with: "4"
    fill_in "Length of Trip", with: "8"

    click_button "Get Travel Policy Price"

    expect(page).to have_text("We were unable to calculate the travel insurance price due to")

    fill_in "Age", with: "40"

    click_button "Get Travel Policy Price"

    expect(page).to have_text("Your Travel Insurance price is $60.")
  end

  scenario "Traveler enters invalid length of trip and can correct and get a price" do
    visit "/policy_prices/new"

    fill_in "Age", with: "40"
    fill_in "Length of Trip", with: "2.5"

    click_button "Get Travel Policy Price"

    expect(page).to have_text("We were unable to calculate the travel insurance price due to")

    fill_in "Length of Trip", with: "8"
    
    click_button "Get Travel Policy Price"
    
    expect(page).to have_text("Your Travel Insurance price is $60.")
  end
end