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
    transactions = @sales_engine_instance.transactions.find_all_by_invoice_id(self.id)
  end

  def items
    # find all invoice items that contains this invoice number
    current_invoice_items = @sales_engine_instance.invoice_items.find_all_by_invoice_id(self.id)
    # in each of those invoice items get the item number
    item_ids = current_invoice_items.map do |invoice_item|
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
    # transactions = @sales_engine_instance.transactions.find_all_by_invoice_id(self.id)
    # results = transactions.map do |transaction|
    #   true if transaction.result == "success"
    # end
    #
    # if results.all? { |result| result == true }
    #   true
    # else
    #   false
    # end

    # if self.status != :shipped
    #   false
    # else
    #   true
    # end
    false
  end

  def total
    #invoice item has quantity and unit_price of each item on the invoice
    # so find all invoice_items that have self.id = invoice_id
    # then map over invoice_items and multiply quantity * unit_price_to_dollars
    # then reduce
    current_invoice_items = @sales_engine_instance.invoice_items.find_all_by_invoice_id(self.id)

    total = current_invoice_items.map do |invoice_item|
      (invoice_item.quantity * invoice_item.unit_price_to_dollars)
    end.reduce(:+).round(2)

    total
  end

end
