require 'pry'
require 'bigdecimal'
require 'time'

class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(hash, sales_engine_instance = nil)
    @id = hash[:id].to_i
    @invoice_id = hash[:invoice_id].to_i
    @credit_card_number = hash[:credit_card_number].to_i
    @credit_card_expiration_date = hash[:credit_card_expiration_date]
    @result = hash[:result]
    @created_at = Time.parse(hash[:created_at])
    @updated_at = Time.parse(hash[:updated_at])
    @sales_engine_instance = sales_engine_instance
  end

  def invoice
    invoice_id = self.invoice_id

    invoice = @sales_engine_instance.invoices.find_by_id(invoice_id)
    invoice
  end

end
