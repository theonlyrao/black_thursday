require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new({:id => 5, :name => "Turing School"})
  end

  def test_a_merchant_is_creatable
    assert_equal Merchant, @merchant.class
  end

  def test_a_merchant_has_an_id
    assert_equal 5, @merchant.id
  end

  def test_a_merchant_has_a_name
    assert_equal "Turing School", @merchant.name
  end

  def test_can_look_up_a_merchants_items
    se = SalesEngine.from_csv({:items     => "./data/fixtures/item_stub.csv",
                                :merchants => "./data/merchants.csv"})
    merchant = se.merchants.find_by_id(12334195)
    merchant_items = merchant.items

    assert_equal 12, merchant_items.count
  end

  def test_can_look_up_merchants_invoices
    se = SalesEngine.from_csv({:items => "./data/fixtures/item_stub.csv",
                               :merchants => "./data/merchants.csv",
                               :invoices => "./data/fixtures/invoice_stub.csv"
                              })

    merchant = se.merchants.find_by_id(12334986)
    invoices = merchant.invoices

    assert_equal 2, invoices.count
    assert_equal Invoice, invoices.first.class
  end

  def test_merchants_know_their_customers
    se = SalesEngine.from_csv({
      :items => "./data/fixtures/item_stub.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/fixtures/invoice_stub.csv",
      :invoice_items => "./data/fixtures/invoice_items_stub.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })

    merchant = se.merchants.find_by_id(12335545)
    customers = merchant.customers

    assert_equal [], customers
  end
end
