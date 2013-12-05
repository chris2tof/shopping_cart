class CartRow
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer, default: 1
  field :total, type: Money

  belongs_to :item
  belongs_to :cart

  delegate :title, to: :item, prefix: true, allow_nil: true
  delegate :price, to: :item, prefix: true, allow_nil: true
  delegate :ref, to: :item, prefix: true, allow_nil: true

  before_save :calculate_total

  def increment
  	self.quantity += 1
  	self.save
  end

  private

  def calculate_total
  	self.total = self.item_price * self.quantity
  end

end