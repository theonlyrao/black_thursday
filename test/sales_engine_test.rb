require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative "../lib/sales_engine"


class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({:items     => "./data/fixtures/item_stub.csv",
                                :merchants => "./data/merchants.csv",
                                :invoices => "./data/fixtures/invoice_stub.csv"})
  end

  def test_from_csv_returns_SalesEngine_with_csv_object
    assert_equal SalesEngine, @se.class
  end

  def test_items_returns_instance_of_ItemRepository
    assert_equal ItemRepository, @se.items.class
  end

  def test_merchants_returns_instance_of_MerchantRepository
    assert_equal MerchantRepository, @se.merchants.class
  end

  def test_magic_returns_an_array_populated_with_item_instances
    assert_equal "ItemRepo with 256 Items", @se.items.inspect
  end

  def test_invoices_returns_instance_of_InvoiceRepository
    assert_equal InvoiceRepository, @se.invoices.class
  end
end
