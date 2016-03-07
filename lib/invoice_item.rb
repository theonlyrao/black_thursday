require 'pry'
require 'bigdecimal'
require 'time'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(hash, sales_engine_instance = nil)
    @id = hash[:id].to_i
    @item_id = hash[:item_id].to_i
    @invoice_id = hash[:invoice_id].to_i
    @quantity = hash[:quantity].to_i
    @unit_price = BigDecimal.new((hash[:unit_price].to_f)/100, 4)
    @created_at = Time.parse(hash[:created_at])
    @updated_at = Time.parse(hash[:updated_at])
    @sales_engine_instance = sales_engine_instance
  end

  def unit_price_to_dollars
    (self.unit_price.to_f)/100
  end

end
