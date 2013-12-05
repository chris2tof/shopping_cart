class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :cart_rows

  def count
  	self.cart_rows.present? ? self.cart_rows.inject(0){|sum, row| sum + row.quantity} : 0
  end

  def total
  	self.cart_rows.present? ? self.cart_rows.inject(0){|sum, row| sum + row.total} : 0
  end

end