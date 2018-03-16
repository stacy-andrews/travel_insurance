class PolicyPricesController < ApplicationController
  def new
    @policy_price_form = ::PolicyPriceForm.new
  end

  def create
    @policy_price_form  = PolicyPriceForm.new(form_params)

    unless @policy_price_form.valid?
      render :new
    end
  end

  private

  def form_params
    params.require(:policy_price_form).
          permit(:age, :length_of_trip)
  end
end
