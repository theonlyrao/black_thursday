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
    @sales_engine_instance.transactions.find_all_by_invoice_id(self.id)
  end

  def items
    # find all invoice items that contains this invoice number
    invoice_items = @sales_engine_instance.invoice_items
    result_inv_items = invoice_items.find_all_by_invoice_id(self.id)
    # in each of those invoice items get the item number
    item_ids = result_inv_items.map do |invoice_item|
      invoice_item.item_id
    end

    items = item_ids.map do |item_id|
      @sales_engine_instance.items.find_by_id(item_id)
    end
    # go to item repo and get each of those item instances
  end

  def customer
    customer_id = self.customer_id

    customer = @sales_engine_instance.customers.find_by_id(customer_id)
    customer
  end

  def is_paid_in_full?
    t = @sales_engine_instance.transactions.find_all_by_invoice_id(self.id)
    t.any? do |transaction|
      transaction.result == "success"
    end
  end

  def total
    invoice_items = @sales_engine_instance.invoice_items
    result_inv_items = invoice_items.find_all_by_invoice_id(self.id)

    total = result_inv_items.map do |invoice_item|
      (invoice_item.quantity * invoice_item.unit_price)
    end.reduce(:+).round(2)

    total
  end

end
