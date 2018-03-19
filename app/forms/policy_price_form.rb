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
  validate :departure_date_must_be_today_or_in_the_future

  validates :return_date, presence: true
  validate :return_date_must_be_a_valid_date

  validate :return_date_must_be_after_the_start_date

  def to_h
    {
      age:            age,
      length_of_trip: length_of_trip
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

  def length_of_trip
    (parsed_return_date - parsed_departure_date) + 1
  end

  def parsed_departure_date
    DateTime.parse departure_date rescue nil
  end

  def parsed_return_date
    DateTime.parse return_date rescue nil
  end

  def departure_date_must_be_a_valid_date
    if departure_date.present? && !parsed_departure_date.present?
      errors.add(:departure_date, "Must be a valid date")
    end
  end

  def return_date_must_be_a_valid_date
    if return_date.present? && !parsed_return_date.present?
      errors.add(:return_date, "Must be a valid date")
    end
  end

  def return_date_must_be_after_the_start_date
    if parsed_return_date.present? &&
       parsed_departure_date.present? &&
       parsed_return_date < parsed_departure_date
       errors.add(:base, "Departure Date must be before the Return Date")
    end
  end

  def departure_date_must_be_today_or_in_the_future
    if parsed_departure_date.present? && parsed_departure_date < Date.today
      errors.add(:departure_date, "Departure Date must be today or in the future")
    end
  end
end