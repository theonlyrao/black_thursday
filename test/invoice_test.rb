require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  def setup
    @i = Invoice.new({
        :id          => "6",
        :customer_id => "7",
        :merchant_id => "8",
        :status      => "pending",
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
      })
  end

  def test_new_invoice_exists
    assert_equal Invoice, @i.class
  end

  def test_id_returns_id
    assert_equal 6, @i.id
  end

  def test_customer_id_returns_customer_id
    assert_equal 7, @i.customer_id
  end

  def test_merchant_id_returns_merchant_id
    assert_equal 8, @i.merchant_id
  end

  def test_status_returns_status
    assert_equal :pending, @i.status
  end

  def test_created_at_is_time
    assert_equal Time, @i.created_at.class
  end

  def test_updated_at_is_time
    assert_equal Time, @i.updated_at.class
  end

  def test_merchant_finds_selling_merchants_instance
    se = SalesEngine.from_csv({:items => "./data/fixtures/item_stub.csv",
                               :merchants => "./data/merchants.csv",
                               :invoices => "./data/fixtures/invoice_stub.csv"
                              })

    invoice = se.invoices.find_by_id(20)
    merchant = invoice.merchant

    assert_equal 12336163, merchant.id
    assert_equal Merchant, merchant.class
  end
end
