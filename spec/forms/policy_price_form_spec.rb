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

  it "is not valid when the departure date is not a date" do
    form = PolicyPriceForm.new(departure_date: 'a')
    expect(form).to_not be_valid

    expect(form.errors[:departure_date].size).to be(1)
  end

  it "is not valid when the departure date is missing" do
    form = PolicyPriceForm.new(departure_date: nil)
    expect(form).to_not be_valid

    expect(form.errors[:departure_date].size).to be(1)
  end

  it "is not valid when the return date is not a date" do
    form = PolicyPriceForm.new(return_date: 'a')
    expect(form).to_not be_valid

    expect(form.errors[:return_date].size).to be(1)
  end

  it "is not valid when the return date is missing" do
    form = PolicyPriceForm.new(return_date: nil)
    expect(form).to_not be_valid

    expect(form.errors[:return_date].size).to be(1)
  end

  it "is not valid when the departure date occurs after the return date" do
    travel_to(Time.zone.local(2018, 3, 19)) do
      form = PolicyPriceForm.new(return_date: '2018-03-19', departure_date: '2018-04-19')
      expect(form).to_not be_valid

      expect(form.errors[:base].size).to be(1)
    end
  end

  it "is not valid when the departure date occurs before the current date" do
    travel_to(Time.zone.local(2018, 3, 19)) do
      form = PolicyPriceForm.new(departure_date: '2018-02-19')
      expect(form).to_not be_valid

      expect(form.errors[:departure_date].size).to be(1)
    end
  end

  it 'is valid when the departure date occurs today or in the future' do
    travel_to(Time.zone.local(2018, 3, 19)) do
      form = PolicyPriceForm.new(departure_date: '2018-03-19')
      form.valid?

      expect(form.errors[:departure_date].size).to be(0)
    end
  end

  it 'is valid when return date is the same as the departure date, it is classed as 1 days travel (an assumption)' do
    travel_to(Time.zone.local(2018, 3, 19)) do
      form = PolicyPriceForm.new(departure_date: '2018-03-19', return_date: '2018-03-19')
      form.valid?

      expect(form.errors[:departure_date].size).to be(0)
      expect(form.errors[:return_date].size).to be(0)
      expect(form.errors[:base].size).to be(0)
    end
  end
end