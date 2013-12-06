class Money
  include Mongoid::Fields::Serializable
  
  def deserialize(object)
    object ? (::BigDecimal.new(object.to_s) / 100) : object
  end
  
  def serialize(object)
    object ? (BigDecimal.new(object.to_s).round(2) * 100).to_i : object
  end
  
end