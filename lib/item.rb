require 'pry'
require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(hash)
<<<<<<< HEAD
    @id = hash[:id].to_i
=======
    @id = hash[:id]
>>>>>>> 81351c4f2966a11c9194ec1f25c58ed328cac9e6
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = hash[:unit_price]
    ##make big decimal here
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
    @merchant_id = hash[:merchant_id].to_i
  end

  def unit_price_to_dollars
    (self.unit_price.to_f)/100
  end

end
