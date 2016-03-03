require 'pry'
require_relative 'item_repository'
require_relative 'merchant'

class ItemsByMerchantSearcher

  attr_reader :merchants_items

  def initialize(merchant_id, items_in_sales_engine)
    @merchant_id = merchant_id
    @items_in_sales_engine = items_in_sales_engine
    find_merchants_items
  end

  def self.push_items(merchant_id, items_in_sales_engine)
    ItemsByMerchantSearcher.new(merchant_id, items_in_sales_engine)
  end

  def find_merchants_items
    item_repository = ItemRepository.new(@items_in_sales_engine)
    @merchants_items = item_repository.find_all_by_merchant_id(@merchant_id)
    Merchant.push_items_to_merchant(@merchants_items)
  end

end
