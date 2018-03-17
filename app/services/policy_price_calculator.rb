class PolicyPriceCalculator
  @@short_trip = (1..7)
  @@medium_trip = (8..14)
  @@long_trip = (15..21)
  @@extra_long_trip = (22..2*365) #upper bounds of 2 years

  @@adult = (18..49)
  @@older_adult = (50..59)
  @@senior_adult = (60..69)

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
end

class PriceNotAvailableError < StandardError  
end 