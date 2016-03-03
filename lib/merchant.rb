require 'pry'
require_relative 'item_repository'
require_relative 'items_by_merchant_searcher'
require_relative 'sales_engine'

class Merchant

  attr_reader :id, :name

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
  end

  def items
    SalesEngine.push_to_merchant_searcher(self.id)
    Merchant.items_being_sold
  end

  def self.push_items_to_merchant(items)
    @merchants_items_being_sold = items
  end

  def self.items_being_sold
    @merchants_items_being_sold
  end

end
