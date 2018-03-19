require "rails_helper"

describe PolicyPriceForm do
  it "is valid when the users age is between 18 and 69" do
    travel_to(Time.zone.local(2018, 3, 19)) do
      (18..69).each do |age| 
        form = PolicyPriceForm.new(date_of_birth: (age.years.ago + 1.day).to_s)
        form.valid?

        expect(form.errors[:age].size).to be(0)
      end
    end
  end

  it "is not valid when the users age is less than 18" do
    (1..17).each do |age|
      form = PolicyPriceForm.new(date_of_birth: age.years.ago.to_s)
      expect(form).to_not be_valid

      expect(form.errors[:date_of_birth].size).to be(1)
    end
  end

  it "is not valid when the users age is more than 69" do
    (70..100).each do |age|
      form = PolicyPriceForm.new(date_of_birth: age.years.ago.to_s)
      expect(form).to_not be_valid

      expect(form.errors[:date_of_birth].size).to be(1)
    end
  end

  it "is not valid when the date of birth is not a valid iso date" do
    form = PolicyPriceForm.new(date_of_birth: 'a')
    expect(form).to_not be_valid

    expect(form.errors[:date_of_birth].size).to be(1)
  end

  it "is not valid when the date of birth is missing" do
    form = PolicyPriceForm.new(date_of_birth: nil)
    expect(form).to_not be_valid

    expect(form.errors[:date_of_birth].size).to be(1)
  end

  it "is not valid when the length of trip is not a number" do
    form = PolicyPriceForm.new(length_of_trip: 'a')
    expect(form).to_not be_valid

    expect(form.errors[:length_of_trip].size).to be(1)
  end

  it "is not valid when the length of trip is not whole" do
    form = PolicyPriceForm.new(length_of_trip: '1.5')
    expect(form).to_not be_valid

    expect(form.errors[:length_of_trip].size).to be(1)
  end

  it "is valid when the length of trip is a whole number greater than 0" do
    form = PolicyPriceForm.new(length_of_trip: '25')
    form.valid?

    expect(form.errors[:length_of_trip].size).to be(0)
  end
end