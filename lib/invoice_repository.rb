require 'pry'
require_relative 'invoice'
require_relative 'repository_methods'

class InvoiceRepository

  include RepositoryMethods

  def initialize(invoice_array, sales_engine_instance = nil)
    @things = create_invoices(invoice_array, sales_engine_instance)
  end

  def inspect
    "InvoiceRepo with #{@things.count} Invoices"
  end

  def create_invoices(invoices_array, sales_engine_instance)
    invoices_array.map do |hash_of_invoice_info|
      Invoice.new(hash_of_invoice_info, sales_engine_instance)
    end
  end

end
