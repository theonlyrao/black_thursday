require 'pry'
require 'bigdecimal'
require 'time'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(hash, sales_engine_instance = nil)
    @id = hash[:id].to_i
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = BigDecimal.new((hash[:unit_price].to_f)/100, 4)
    @created_at = Time.parse(hash[:created_at])
    @updated_at = Time.parse(hash[:updated_at])
    @merchant_id = hash[:merchant_id].to_i
    @sales_engine_instance = sales_engine_instance
  end

  def unit_price_to_dollars
    (self.unit_price.to_f)/100
  end

  def merchant
    @sales_engine_instance.merchants.find_by_id(self.merchant_id)
  end

end
