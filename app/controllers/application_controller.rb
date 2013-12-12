class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_cart, :set_locale

  private

  def set_cart
  	if session[:cart].present?
  		@cart = Cart.find(session[:cart][:id]) rescue nil
  	end
  	unless @cart
			@cart = Cart.create
			session[:cart] = {id: @cart.id}
		end
  end

  def set_locale
    @ordered_locales
  end

  # Set I18n.locale
  def set_locale
    # update session if passed
    session[:locale] = params[:locale] if params[:locale]
    
    # get browser locale
    browser_locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first rescue nil
    browser_locale = nil unless VALID_LOCALES.include?(browser_locale)

    session[:locale] = session[:locale] || browser_locale || I18n.default_locale.to_s
    I18n.locale = session[:locale].to_sym
    @ordered_locales = site_locales_default_head(VALID_LOCALES)
  end

  def site_locales_default_head(locales)
    if locales[0].eql? I18n.locale.to_s
      locales
    else
      a = Array.new(locales)
      shift_out = a.delete(I18n.locale.to_s)
      [shift_out] + a
    end
  end

end
