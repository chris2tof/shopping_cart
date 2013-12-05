class Item
  include Mongoid::Document
  include Mongoid::Timestamps
	
  field :details, localize: true
  field :price, type: Money
  field :ref
  field :title, localize: true

  has_many :cart_rows

end