require 'minitest/autorun'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_invoice_item_instance_exists
    ii = InvoiceItem.new({:id => 1,
                          :item_id => 2,
                          :invoice_id => 3,
                          :quantity => 4,
                          :unit_price => "30",
                          :created_at => "2012-03-27 14:54:09 UTC",
                          :updated_at => "2012-03-27 14:54:09 UTC"
                        })

    assert_equal InvoiceItem, ii.class
  end

end
