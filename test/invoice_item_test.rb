require 'minitest/autorun'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_invoice_item_instance_exists
    ii = InvoiceItem.new({})

    assert_equal InvoiceItem, ii.class
  end

end
