require 'pry'
require_relative 'repository_methods'
require_relative 'sales_engine'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :sales_engine_instance

  include RepositoryMethods

  def initialize
  end

  def inspect
    "InvoiceItemRepo with #{@things.count} InvoiceItems"
  end

  def from_csv(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
    invoice_items = contents.map do |row|
      row.to_h
    end
    create_invoice_item_items(invoice_items)
  end

  def create_invoice_item_items(invoice_item_array, sales_engine_instance = nil)
    @sales_engine_instance = sales_engine_instance
    @things = invoice_item_array.map do |hash_of_invoice_item_info|
      InvoiceItem.new(hash_of_invoice_item_info, sales_engine_instance)
    end
    unless @sales_engine_instance.nil?
      @sales_engine_instance.invoice_items = self
    end
  end

end
