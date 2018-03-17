require "rails_helper"

RSpec.feature "App Root" do
  scenario "Traveler goes to the root url it redirects to the policy price creation" do
    visit "/"

    expect(page).to have_current_path(new_policy_price_path, ignore_query: true)
  end
end