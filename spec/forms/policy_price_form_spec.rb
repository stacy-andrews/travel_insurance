require "rails_helper"

describe PolicyPriceForm do
  def is_valid(param)
    form = PolicyPriceForm.new(param)
    form.valid?

    expect(form.errors[param.keys.first].size).to be(0)
  end

  def is_not_valid(param)
    form = PolicyPriceForm.new(param)
    expect(form).to_not be_valid

    expect(form.errors[param.keys.first].size).to be(1)
  end

  it "is valid when the users age is between 18 and 69" do
    travel_to(Time.zone.local(2018, 3, 19)) do
      (18..69).each { |age| is_valid(date_of_birth: age.years.ago.to_s) }
    end
  end

  it "is not valid when the users age is less than 18" do
    travel_to(Time.zone.local(2018, 3, 19)) do
      (1..17).each { |age| is_not_valid(date_of_birth: age.years.ago.to_s) }
    end
  end

  it "is not valid when the users age is more than 69" do
    travel_to(Time.zone.local(2018, 3, 19)) do
      (70..100).each  { |age| is_not_valid(date_of_birth: age.years.ago.to_s) }
    end
  end

  it "is not valid when the date of birth is not a valid iso date" do
    is_not_valid(date_of_birth: 'a')
  end

  it "is not valid when the date of birth is missing" do
    is_not_valid(date_of_birth: nil)
  end

  it "is not valid when the departure date is not a date" do
    is_not_valid(departure_date: 'a')
  end

  it "is not valid when the departure date is missing" do
    is_not_valid(departure_date: nil)
  end

  it "is not valid when the return date is not a date" do
    is_not_valid(return_date: 'a')
  end

  it "is not valid when the return date is missing" do
    is_not_valid(return_date: nil)
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
      is_not_valid(departure_date: '2018-02-19')
    end
  end

  it 'is valid when the departure date occurs today or in the future' do
    travel_to(Time.zone.local(2018, 3, 19)) do
      is_valid(departure_date: '2018-03-19')
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