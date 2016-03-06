require 'pry'
require 'csv'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

class SalesEngine

  attr_reader :items, :merchants, :invoices

  def initialize(hash)
    if hash.keys.include?(:items)
      @items = ItemRepository.new(hash[:items], self)
    end
    if hash.keys.include?(:merchants)
      @merchants = MerchantRepository.new(hash[:merchants], self)
    end
    if hash.keys.include?(:invoices)
      @invoices = InvoiceRepository.new(hash[:invoices], self)
    end
  end

  def self.from_csv(hash)
    items_array = item_repo_instance_maker(hash[:items])
    merchants_array = merchant_repo_instance_maker(hash[:merchants])
    invoices_array = invoice_repo_instance_maker(hash[:invoices])
    sales_engine_input = self.decide_what_to_initialize_sales_engine_with(items_array, merchants_array, invoices_array)
    SalesEngine.new(sales_engine_input)
  end

  def self.decide_what_to_initialize_sales_engine_with(items, merchants, invoices)
    sales_engine_input = {}
    unless items.nil?
      sales_engine_input[:items] = items
    end
    unless merchants.nil?
      sales_engine_input[:merchants] = merchants
    end
    unless invoices.nil?
      sales_engine_input[:invoices] = invoices
    end
    sales_engine_input
  end

  def self.item_repo_instance_maker(items_filepath)
    unless items_filepath.nil?
      contents = CSV.open items_filepath, headers: true, header_converters: :symbol
      items = []
      contents.each do |row|
        hash = Hash.new
        hash[:id] = row[:id]
        hash[:name] = row[:name]
        hash[:description] = row[:description]
        hash[:unit_price] = row[:unit_price]
        hash[:merchant_id] = row[:merchant_id]
        hash[:created_at] = row[:created_at]
        hash[:updated_at] = row[:updated_at]
        items << hash
      end
      items
    end
  end

  def self.merchant_repo_instance_maker(merchants_filepath)
    unless merchants_filepath.nil?
      contents = CSV.open merchants_filepath, headers: true, header_converters: :symbol
      merchants = []
      contents.each do |row|
        hash = Hash.new
        hash[:id] = row[:id]
        hash[:name] = row[:name]
        hash[:created_at] = row[:created_at]
        hash[:updated_at] = row[:updated_at]
        merchants << hash
      end
      merchants
    end
  end

  def self.invoice_repo_instance_maker(invoices_filepath)
    unless invoices_filepath.nil?
      contents = CSV.open invoices_filepath, headers: true, header_converters: :symbol
      invoices = []
      contents.each do |row|
        hash = Hash.new
        hash[:id] = row[:id]
        hash[:customer_id] = row[:customer_id]
        hash[:merchant_id] = row[:merchant_id]
        hash[:status] = row[:status]
        hash[:created_at] = row[:created_at]
        hash[:updated_at] = row[:updated_at]
        invoices << hash
      end
      invoices
    end
  end

end
