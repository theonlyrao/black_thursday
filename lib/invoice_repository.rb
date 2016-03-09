require 'pry'
require_relative 'invoice'
require_relative 'repository_methods'

class InvoiceRepository

  attr_reader :things

  include RepositoryMethods

  def initialize
    @things = []
  end

  def inspect
    "InvoiceRepo with #{@things.count} Invoices"
  end

  def from_csv(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
    invoices = contents.map do |row|
      row.to_h
    end
    create_invoice_items(invoices)
  end

  def create_invoice_items(invoices_array, sales_engine_instance = nil)
    @sales_engine_instance = sales_engine_instance
    @things = invoices_array.map do |hash_of_invoice_info|
      Invoice.new(hash_of_invoice_info, sales_engine_instance)
    end
    unless @sales_engine_instance.nil?
      @sales_engine_instance.invoices = self
    end
  end

end
