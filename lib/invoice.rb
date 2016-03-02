require 'pry'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(hash)
    @id = hash[:id]
    @customer_id = hash[:customer_id]
    @merchant_id = hash[:merchant_id]
    @status = hash[:status]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end
end
