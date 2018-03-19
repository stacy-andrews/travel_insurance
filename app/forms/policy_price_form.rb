class PolicyPriceForm
  include ActiveModel::Model

  attr_accessor(
    :length_of_trip,
    :date_of_birth,
    :departure_date,
    :return_date
  )

  # not happy with this, but it works
  validates :date_of_birth, presence: true
  validate :age_must_be_greater_than_minimum_insurable_range,
          :age_must_be_less_than_maximum_insurable_range,
          :date_of_birth_must_be_a_valid_date

  validates :length_of_trip,
            presence: true,
            numericality: { 
              only_integer: true,
              greater_than: PolicyPriceCalculator.minimum_trip_length - 1,
              less_than:    PolicyPriceCalculator.maximum_trip_length + 1
            }

  def to_h
    {
      age:            age,
      length_of_trip: length_of_trip.to_i
    }
  end

  private

  def age
    return nil unless date_of_birth.present?

    dob = parsed_date

    return nil unless dob.present?

    AgeCalculator.age dob
  end

  def parsed_date
    DateTime.parse date_of_birth rescue nil
  end

  def age_must_be_greater_than_minimum_insurable_range
    if age.present? && age < PolicyPriceCalculator.minimum_age
      errors.add(:date_of_birth, "Must be older than #{PolicyPriceCalculator.minimum_age}")
    end
  end

  def age_must_be_less_than_maximum_insurable_range
    if age.present? && age > PolicyPriceCalculator.maximum_age
      errors.add(:date_of_birth, "Must be younger than #{PolicyPriceCalculator.maximum_age}")
    end
  end

  def date_of_birth_must_be_a_valid_date
    if date_of_birth.present? && !parsed_date.present?
      errors.add(:date_of_birth, "Must be a valid date")
    end
  end
end