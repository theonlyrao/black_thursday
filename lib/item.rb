require 'pry'
require 'bigdecimal'

class Item

  attr_reader :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(hash)
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = hash[:unit_price]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end

  def unit_price_to_dollars
    self.unit_price.to_f
  end

end
