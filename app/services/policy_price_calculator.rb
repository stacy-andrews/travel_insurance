class PolicyPriceCalculator
  @@minimun_age = 18
  @@maximum_age = 69
  @@minimum_trip_length = 1
  @@maximum_trip_length = 2*365
  
  @@short_trip = (@@minimum_trip_length..7)
  @@medium_trip = (8..14)
  @@long_trip = (15..21)
  @@extra_long_trip = (22..@@maximum_trip_length) #upper bounds of approx 2 years

  @@adult = (@@minimun_age..49)
  @@older_adult = (50..59)
  @@senior_adult = (60..@@maximum_age)

  @@price_table = [
    {
      trip_length: @@short_trip,
      age:         @@adult,
      cost:        50
    },
    {
      trip_length: @@short_trip,
      age:         @@older_adult,
      cost:        60
    },
    {
      trip_length: @@short_trip,
      age:         @@senior_adult,
      cost:        70
    },
    {
      trip_length: @@medium_trip,
      age:         @@adult,
      cost:        60
    },
    {
      trip_length: @@medium_trip,
      age:         @@older_adult,
      cost:        73
    },
    {
      trip_length: @@medium_trip,
      age:         @@senior_adult,
      cost:        80
    },
    {
      trip_length: @@long_trip,
      age:         @@adult,
      cost:        70
    },
    {
      trip_length: @@long_trip,
      age:         @@older_adult,
      cost:        80
    },
    {
      trip_length: @@long_trip,
      age:         @@senior_adult,
      cost:        90
    },
    {
      trip_length: @@extra_long_trip,
      age:         @@adult,
      cost:        82
    },
    {
      trip_length: @@extra_long_trip,
      age:         @@older_adult,
      cost:        90
    },
    {
      trip_length: @@extra_long_trip,
      age:         @@senior_adult,
      cost:        100
    }
  ]

  # please note, it was a conscious choice to name the parameters
  # as it could be easy to confuse age with length of trip when using
  # this method without them.
  def calculate_price(age:, length_of_trip:)
    applicable_entry = @@price_table.find { |entry|
       entry[:trip_length].find { |a| a == length_of_trip  } && 
       entry[:age].find { |a| a == age  }
    }

    raise PriceNotAvailableError unless applicable_entry

    applicable_entry[:cost]
  end

  def self.minimum_trip_length
    @@minimum_trip_length
  end

  def self.maximum_trip_length
    @@maximum_trip_length
  end

  def self.minimum_age
    @@minimun_age
  end

  def self.maximum_age
    @@maximum_age
  end
end

class PriceNotAvailableError < StandardError  
end 