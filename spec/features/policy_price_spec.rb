require "rails_helper"

RSpec.feature "Policy Prices" do
  scenario "Traveler enters their age and length of trip" do
    visit "/policy_prices/new"

    fill_in "Age", with: "40"
    fill_in "Length of Trip", with: "8"

    click_button "Get Travel Policy Price"

    expect(page).to have_text("Your Travel Insurance price is $60.")
  end
end