require "rails_helper"

# | Age of traveller | 18-49 | 50-59 | 60-69 |
# |------------------|-------|-------|-------|
# | Length of trip   |       |       |       |
# | 1-7 days         | $50   | $60   | $70   |
# | 8-14 days        | $60   | $73   | $80   |
# | 15-21 days       | $70   | $80   | $90   |
# | 22+ days         | $82   | $90   | $100  |

describe PolicyPriceCalculator do
  it 'can calculate a price' do
    expect(
      PolicyPriceCalculator.new.calculate_price(age: 40, length_of_trip: 8)
    ).to eq(60)
  end

  def values_for_ranges(age, *values)
    (1..7).each do |trip_length|
      expect(
        PolicyPriceCalculator.new.calculate_price(age: age, length_of_trip: trip_length)
      ).to eq(values[0])
    end
    (8..14).each do |trip_length|
      expect(
        PolicyPriceCalculator.new.calculate_price(age: age, length_of_trip: trip_length)
      ).to eq(values[1])
    end
    (15..21).each do |trip_length|
      expect(
        PolicyPriceCalculator.new.calculate_price(age: age, length_of_trip: trip_length)
      ).to eq(values[2])
    end
  end

  it 'correctly returns price table prices for 18-49 year olds' do
    (18..49).each do |age|
      values_for_ranges age, 50, 60, 70, 82
    end
  end

  it 'correctly returns price table prices for 50-59 year olds' do
    (50..59).each do |age|
      values_for_ranges age, 60, 73, 80, 90
    end
  end

  it 'correctly returns price table prices for 60-59 year olds' do
    (60..69).each do |age|
      values_for_ranges age, 70, 80, 90, 100
    end
  end
end
