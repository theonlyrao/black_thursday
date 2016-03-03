require 'pry'
require 'csv'
require_relative 'merchant'
require_relative 'item'
require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine

  attr_reader :sales_engine_hash

  # SalesEngine.new
  # in initialize, `self` will be that new SE that was just created

  def initialize(hash)
    # instead of storing just items and merchants, can i store the actual repositories
    # then whenever you ask me sales_engine.items i can give you the one i stored before instead
    # of having to make a new one


    @items = hash[:items]
    @merchants = hash[:merchants]

    @item_repo = ItemRepository.new(@items)
    # making new merchant repo -- give it the merchants
    # but also give it something that allows it to connect to Item information


    @merchant_repo = MerchantRepository.new(@merchants)
    # @merchant_repo = MerchantRepository.new(@merchants, self)
    # @merchant_repo = MerchantRepository.new(@merchants, item_repo)
  end

  def self.from_csv(hash)
    items_array = item_instance_maker(hash[:items])
    merchants_array = merchant_instance_maker(hash[:merchants])
    @sales_engine_hash = {:items => items_array, :merchants => merchants_array}
    SalesEngine.new(@sales_engine_hash)
  end

  def items
    ItemRepository.new(@items)
  end

  def merchants
    MerchantRepository.new(@merchants)
  end

  def self.push_to_merchant_searcher(merchant_instance_id)
    ItemsByMerchantSearcher.push_items(merchant_instance_id,
                                       @sales_engine_hash[:items])
  end

  def self.item_instance_maker(items_filepath)
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
      items << Item.new(hash)
    end
    items
  end

  def self.merchant_instance_maker(merchants_filepath)
    contents = CSV.open merchants_filepath, headers: true, header_converters: :symbol
    merchants = []
    contents.each do |row|
      hash = Hash.new
      hash[:id] = row[:id]
      hash[:name] = row[:name]
      hash[:created_at] = row[:created_at]
      hash[:updated_at] = row[:updated_at]
      merchants << Merchant.new(hash)
    end
    merchants
  end

end
