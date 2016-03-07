require 'pry'
require 'csv'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'

class SalesEngine

  attr_reader :items, :merchants, :invoices, :invoice_items

  def initialize(array, repo)
    array.each do |type, hash|
      if type == :items
        # @items = ItemRepository.new(hash, self)
        @items = ItemRepository.send_csv_contents_to_repo(hash, self)
      end
      if type == :merchants
        @merchants = MerchantRepository.new(hash, self)
      end
      if type == :invoices
        @invoices = InvoiceRepository.new(hash, self)
      end
      if type == :invoice_items
        @invoice_items = InvoiceItemRepository.send_csv_contents_to_repo(hash, repo, self)
      end
    end
  end

  def self.from_csv(hash, repo = nil)
    sales_engine_input = hash.map do |type, filepath|
      [type, parse_csv(filepath)]
    end
    SalesEngine.new(sales_engine_input, repo)
  end

  def self.parse_csv(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
    items = contents.map do |row|
      row.to_h
    end
    items
  end

end
