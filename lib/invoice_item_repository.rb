require 'pry'
require_relative 'repository_methods'
require_relative 'repository_creator'
require_relative 'sales_engine'
require_relative 'invoice_item'

class InvoiceItemRepository

  attr_reader :sales_engine_instance

  # include RepositoryMethods

  def initialize
  end

  def from_csv(filepath)
    for_sales_engine = { invoice_items: filepath }
    SalesEngine.from_csv(for_sales_engine, self)
  end

  def self.send_csv_contents_to_repo(invoice_item_hash, invoice_item_instance, sales_engine_instance)
    if invoice_item_instance.nil?
      invoice_item_repo = InvoiceItemRepository.new
      invoice_item_repo.create_invoice_items(invoice_item_hash, sales_engine_instance)
      return invoice_item_repo
    else
      create_invoice_items(invoice_item_hash, sales_engine_instance)
      return invoice_item_instance
    end
  end

  def inspect
    "InvoiceItemRepo with #{@things.count} InvoiceItems"
  end

  def create_invoice_items(invoice_item_array, sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
    @things = invoice_item_array.map do |hash_of_invoice_item_info|
      InvoiceItem.new(hash_of_invoice_item_info, sales_engine_instance)
    end
  end

  def find_all_by_item_id(item_id)
    find_all_by_thing_id(item_id)
  end

  def all
    @things
  end


end
