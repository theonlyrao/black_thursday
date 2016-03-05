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
end
