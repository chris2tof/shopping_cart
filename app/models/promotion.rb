class Promotion
  include Mongoid::Document
  include Mongoid::Timestamps

  field :details, localize: true
  field :end_date, type: DateTime
  field :new_price, type: Money
  field :on
  field	:percentage, type: Integer
  field :price, type: Money
  field :quantity, type: Integer
  field :ref
  field :start_date, type: DateTime
  field :title, localize: true
  field :type

  TARGETS = %w[cart item_].sort

  belongs_to :discountable, polymorphic: true

end