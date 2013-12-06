class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :cart_rows

  def count
  	self.cart_rows.present? ? self.cart_rows.inject(0){|sum, row| sum + row.quantity} : 0
  end

  def total
  	total = self.cart_rows.present? ? self.cart_rows.inject(0){|sum, row| sum + row.total} : 0
  	promotions = Promotion.where(on: 'cart')
  	percentage = promotions.inject(0) do |percentage, promotion|
  		percentage = promotion.percentage if (promotion.price <= total && promotion.percentage > percentage)
  		percentage
  	end
  	(total - total * percentage / 100).round(2)
  end

end