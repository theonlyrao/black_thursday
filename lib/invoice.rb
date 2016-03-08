require 'pry'
require 'time'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(hash, sales_engine_instance = nil)
    @id = hash[:id].to_i
    @customer_id = hash[:customer_id].to_i
    @merchant_id = hash[:merchant_id].to_i
    @status = hash[:status].to_sym
    @created_at = Time.parse(hash[:created_at])
    @updated_at = Time.parse(hash[:updated_at])
    @sales_engine_instance = sales_engine_instance
  end

  def merchant
    @sales_engine_instance.merchants.find_by_id(self.merchant_id)
  end

  def transactions
  end

  def items
    # take my self.id (invoices) and go to invoice_item_repository
      # this method is written in repo methods
      # find all invoice_items instances that have this invoice id
    # current_invoice_item = @sales_engine_instance.invoice_items.find_all_by_invoice_id(self.id)
    item_ids = @sales_engine_instance.invoice_items.map do |invoice_item|
      invoice_item.item_id if invoice_item.invoice_id == self.id
    end

    items = item_ids.map do |item_id|
      @sales_engine_instance.items.find_all_by_id(item_id)
    end
    items
    binding.pry
  end

end
