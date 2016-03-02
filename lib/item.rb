require 'pry'
require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = hash[:unit_price]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end

  def unit_price_to_dollars
    (self.unit_price.to_f)/100
  end

end
