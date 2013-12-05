class Promotion
  include Mongoid::Document
  include Mongoid::Timestamps

  field :end_date, type: DateTime
  field :ref
  field :start_date, type: DateTime
  field :type

end