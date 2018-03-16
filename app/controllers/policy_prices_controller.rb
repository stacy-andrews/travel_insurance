class PolicyPricesController < ApplicationController
  def new
    @policy_price_form = ::PolicyPriceForm.new
  end

  def create
    @policy_price_form  = PolicyPriceForm.new(form_params)

    unless @policy_price_form.valid?
      render :new
    end

    @policy_price = PolicyPriceCalculator.new.calculate_price(
      age:            @policy_price_form.age.to_i,
      length_of_trip: @policy_price_form.length_of_trip.to_i
    )
  end

  private

  def form_params
    params.require(:policy_price_form).
          permit(:age, :length_of_trip)
  end
end
