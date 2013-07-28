class TailsController < ApplicationController

  helper_method :spreedly
  rescue_from Spreedly::Error, with: :handle_spreedly_error

  def buy_tail
    @credit_card = CreditCard.new
  end

  def transparent_redirect_complete
    return if error_saving_card

    @credit_card = CreditCard.new(spreedly.find_payment_method(params[:token]))
    return render_buy_tail unless @credit_card.valid?

    transaction = spreedly.purchase_on_gateway(gateway_token, params[:token], amount_to_charge)
    return render_unable_to_process(transaction) unless transaction.succeeded?

    return redirect_to(successful_purchase_url)
  end

  def successful_purchase

  end


  private
  def error_saving_card
    return false if params[:error].blank?

    flash.now[:error] = params[:error]
    render_buy_tail
    true
  end

  def render_buy_tail
    @credit_card = CreditCard.new unless @credit_card
    render(:action => :buy_tail)
  end

  def spreedly
    @spreedly ||= Spreedly::Environment.new(ENV["CORE_ENVIRONMENT_KEY"], ENV["CORE_ACCESS_SECRET"])
  end

  def amount_to_charge
    (( 0.02 * @credit_card.how_many.to_i ) * 100).to_i
  end

  def gateway_token
    ENV["CORE_GATEWAY_FOR_CREDIT_CARD"]
  end

  def render_unable_to_process(transaction)
    flash.now[:error] = transaction.message
    render_buy_tail
  end

  def handle_spreedly_error(error)
    flash.now[:error] = error.message
    render_buy_tail
  end
end
