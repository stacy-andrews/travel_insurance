class PolicyPriceForm
  include ActiveModel::Model

  attr_accessor(
    :age,
    :length_of_trip
  )

  validates :age,
            presence: true,
            numericality: { 
              only_integer: true, 
              greater_than: PolicyPriceCalculator.minimum_age - 1,
              less_than:    PolicyPriceCalculator.maximum_age + 1
            }

  validates :length_of_trip,
            presence: true,
            numericality: { 
              only_integer: true,
              greater_than: PolicyPriceCalculator.minimum_trip_length - 1,
              less_than:    PolicyPriceCalculator.maximum_trip_length + 1
            }

  def to_h
    {
      age:            age.to_i,
      length_of_trip: length_of_trip.to_i
    }
  end
end