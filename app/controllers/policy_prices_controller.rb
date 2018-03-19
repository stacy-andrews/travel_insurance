class PolicyPricesController < ApplicationController
  def new
    @policy_price_form = ::PolicyPriceForm.new
  end

  def create
    @policy_price_form  = PolicyPriceForm.new(form_params)
    unless @policy_price_form.valid?
      render :new and return
    end

    # the spec says redirect, 
    # I am assuming posting to the /policy_prices url is what was meant
    price_request = @policy_price_form.to_h

    @policy_price = PolicyPriceCalculator.new.calculate_price(
      age:            price_request[:age],
      length_of_trip: price_request[:length_of_trip]
    )
  end

  private

  def form_params
    params.require(:policy_price_form).
          permit(:date_of_birth, :length_of_trip)
  end
end
