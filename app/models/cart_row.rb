class CartRow
  include Mongoid::Document
  include Mongoid::Timestamps

  # field :price, type: Money
  field :quantity, type: Integer, default: 1
  # field :total, type: Money

  belongs_to :item
  belongs_to :cart

  delegate :title, to: :item, prefix: true, allow_nil: true
  delegate :price, to: :item, prefix: true, allow_nil: true
  delegate :promotions, to: :item, prefix: true, allow_nil: true
  delegate :ref, to: :item, prefix: true, allow_nil: true

  # before_save :calculate_total

  def increment
  	self.quantity += 1
  	self.save
  end

  def price
  	value = self.item_promotions.inject(self.item_price) do |price, promotion|
  		price = promotion.new_price if promotion.quantity <= self.quantity
  		price
  	end
  	value
  end

  def total
  	price * self.quantity
  end

  # private

  # def calculate_total
  # 	self.price = self.item_promotions.inject(self.item_price) do |promotion, price|
  # 		price = promotion.price if promotion.quantity <= self.quantity
  # 		price
  # 	end
  # 	self.total = self.price * self.quantity
  # end

end