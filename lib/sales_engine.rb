require 'pry'
require 'csv'
require_relative 'merchant'
require_relative 'item'

class SalesEngine

  def initialize(hash)
    @items = hash[:items]
    @merchants = hash[:merchants]
  end

  def self.from_csv(hash)
    items_array = item_instance_maker(hash[:items])
    merchants_array = merchant_instance_maker(hash[:merchants])
    hash = {:items => items_array, :merchants => merchants_array}
    SalesEngine.new(hash)
  end

  def items
<<<<<<< HEAD
    Items.new(@items)
  end

  def merchants
    Merchants.new(@merchants)
=======
    @items
  end

  def merchants
    @merchants
>>>>>>> 81351c4f2966a11c9194ec1f25c58ed328cac9e6
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
