require 'pry'
require 'csv'

class SalesEngine

  def from_csv(hash)
    items_array = items_array_maker(hash[:items])
    merchants_array = merchants_array_maker(hash[:merchants])
    sales_engine_hash = {:items => items_array,
                         :merchants => merchants_array}
  end

  def items_array_maker(items_filepath)
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

  def merchants_array_maker(merchants_filepath)
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
