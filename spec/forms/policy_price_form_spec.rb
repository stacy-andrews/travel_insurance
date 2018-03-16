require "rails_helper"

describe PolicyPriceForm do
  it "is not valid when the age is a number less than 18" do
    form = PolicyPriceForm.new(age: -4)
    expect(form).to_not be_valid

    expect(form.errors[:age].size).to be(1)
  end

  it "is not valid when the age is not a number" do
    form = PolicyPriceForm.new(age: 'a')
    expect(form).to_not be_valid

    expect(form.errors[:age].size).to be(1)
  end

  it "is not valid when the age is not entered" do
    form = PolicyPriceForm.new(age: nil)
    expect(form).to_not be_valid
    
    expect(form.errors[:age].size).to be(2)
  end

  it "is valid when the age is a whole number 18 or more and less than 100" do
    (18..69).each do |age|
      form = PolicyPriceForm.new(age: age.to_s)
      form.valid?

      expect(form.errors[:age].size).to be(0)
    end
  end

  it "is not valid when the length of trip is not a number" do
    form = PolicyPriceForm.new(length_of_trip: 'a')
    expect(form).to_not be_valid

    expect(form.errors[:length_of_trip].size).to be(1)
  end

  it "is not valid when the length of trip is not whole" do
    form = PolicyPriceForm.new(length_of_trip: 1.5)
    expect(form).to_not be_valid

    expect(form.errors[:length_of_trip].size).to be(1)
  end

  it "is valid when the length of trip is a whole number greater than 0" do
    form = PolicyPriceForm.new(length_of_trip: '25')
    form.valid?

    expect(form.errors[:length_of_trip].size).to be(0)
  end
end