class PolicyPriceForm
  include ActiveModel::Model

  attr_accessor(
    :date_of_birth,
    :departure_date,
    :return_date
  )

  # not happy with this, but it works
  validates :date_of_birth, presence: true
  validate :age_must_be_greater_than_minimum_insurable_range,
          :age_must_be_less_than_maximum_insurable_range,
          :date_of_birth_must_be_a_valid_date

  validates :departure_date, presence: true
  validate :departure_date_must_be_a_valid_date

  # validates :length_of_trip,
  #           presence: true,
  #           numericality: { 
  #             only_integer: true,
  #             greater_than: PolicyPriceCalculator.minimum_trip_length - 1,
  #             less_than:    PolicyPriceCalculator.maximum_trip_length + 1
  #           }

  def to_h
    byebug
    {
      age:            age,
      length_of_trip: (parsed_return_date - parsed_departure_date) + 1
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

  def parsed_departure_date
    DateTime.parse departure_date rescue nil
  end

  def parsed_return_date
    DateTime.parse return_date rescue nil
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

  def departure_date_must_be_a_valid_date
    if departure_date.present? && !parsed_departure_date.present?
      errors.add(:departure_date, "Must be a valid date")
    end
  end
end