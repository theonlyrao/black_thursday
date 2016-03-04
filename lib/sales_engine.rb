require 'CSV'
require_relative 'item_repository'
require_relative 'item'
require 'pry'

class SalesEngine

  attr_reader :csvs

  def initialize(csvs)
    @csvs = csvs
    # right here we have a hash with csv objects
    # we need to turn these csv objects into arrays of item and merchant instances
  end

  def self.from_csv(filepath_hash)
#
# (filepath_hash = {:items     => "../data/fixtures/item_stub.csv",
#                   :merchants => "../data/merchants.csv"})

    csv_content = {}
    filepath_hash.each do |key, filepath|
      csv_content[key] = pull_from_csv(filepath)
    end
    SalesEngine.new(csv_content)
  end

  def self.pull_from_csv(filepath)
    content = CSV.open filepath, headers: true, header_converters: :symbol
    #returns csv object
  end

  def items
    item_array = magic_item_array_creator(@csvs[:items])
    repo = ItemRepository.new(item_array)
  end

  def magic_item_array_creator(csv_object)
    item_array = []
    csv_object.each do |row|
      hash = {}
      hash[:id] = row[:id]
      hash[:name] = row[:name]
      hash[:description] = row[:description]
      hash[:unit_price] = row[:unit_price]
      hash[:created_at] = row[:created_at]
      hash[:updated_at] = row[:updated_at]
      hash[:merchant_id] = row[:merchant_id]
      item_array << Item.new(hash)
    end
    item_array
  end

end
