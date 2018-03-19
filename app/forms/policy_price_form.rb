class PolicyPriceForm
  include ActiveModel::Model

  attr_accessor(
    :age,
    :length_of_trip,
    :date_of_birth
  )

  validate :age_must_be_greater_than_insurable_range

  # validates :age,
  #           presence: true,
  #           numericality: { 
  #             only_integer: true, 
  #             greater_than: PolicyPriceCalculator.minimum_age - 1,
  #             less_than:    PolicyPriceCalculator.maximum_age + 1
  #           }
  validates :date_of_birth, presence: true

  validates :length_of_trip,
            presence: true,
            numericality: { 
              only_integer: true,
              greater_than: PolicyPriceCalculator.minimum_trip_length - 1,
              less_than:    PolicyPriceCalculator.maximum_trip_length + 1
            }

  def to_h
    {
      age:            age_from,
      length_of_trip: length_of_trip.to_i
    }
  end

  private

  def age_from
    return nil unless date_of_birth.present?

    dob = Date.parse(date_of_birth)
    
    now = Time.now.utc.to_date

    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def age_must_be_greater_than_insurable_range
    if age_from.present? && age_from < PolicyPriceCalculator.minimum_age
      errors.add(:date_of_birth, "Must be older than #{PolicyPriceCalculator.minimum_age}")
    end
  end
end