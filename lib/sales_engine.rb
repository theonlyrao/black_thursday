require 'pry'
require 'csv'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine

  attr_accessor :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(hash)
    @transactions = []
    Loader.new(self, hash)
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

end
