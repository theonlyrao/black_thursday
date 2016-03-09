require 'pry'
require_relative 'item_repository'
require_relative 'sales_engine'

class Merchant

  attr_reader :id, :name

  def initialize(hash, sales_engine_instance = nil)
    @id = hash[:id].to_i
    @name = hash[:name]
    @sales_engine_instance = sales_engine_instance
  end

  def items
    @sales_engine_instance.items.find_all_by_merchant_id(self.id)
  end

  def invoices
    @sales_engine_instance.invoices.find_all_by_merchant_id(self.id)
  end

  def customers
    invoices = @sales_engine_instance.invoices
    result_inv = invoices.find_all_by_merchant_id(self.id)

    customer_ids = result_inv.map do |invoice|
      invoice.customer_id
    end.uniq

    customers = customer_ids.map do |id|
      @sales_engine_instance.customers.find_by_id(id)
    end
    customers
  end
end
