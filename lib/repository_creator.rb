require 'pry'

class RepositoryCreator

  def initialize(filepath)
    make_repository(filepath)
  end

  def make_repository(filepath)
    contents = CSV.open items_filepath, headers: true, header_converters: :symbol
    things = []
    contents.each do |row|
      hash = Hash.new
      hash[:id] = row[:id]
      hash[:name] = row[:name]
      hash[:description] = row[:description]
      hash[:unit_price] = row[:unit_price]
      hash[:merchant_id] = row[:merchant_id]
      hash[:created_at] = row[:created_at]
      hash[:updated_at] = row[:updated_at]
      things << hash
    end
    things
  end

end
