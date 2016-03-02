require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
  def setup
    @i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now,
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
    assert_equal "pending", @i.status
  end

  def test_created_at_is_time
    assert_equal Time, @i.created_at.class
  end

  def test_updated_at_is_time
    assert_equal Time, @i.updated_at.class
  end
end
