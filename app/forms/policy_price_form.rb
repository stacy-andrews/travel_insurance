class PolicyPriceForm
  include ActiveModel::Model

  attr_accessor(
    :age,
    :length_of_trip
  )

  validates :age,
            presence: true,
            numericality: { only_integer: true, 
                            greater_than: 17,
                            less_than: 70 }

  validates :length_of_trip,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  def to_h
    {
      age: age.to_i,
      length_of_trip: length_of_trip.to_i
    }
  end
end