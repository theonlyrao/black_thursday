require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test


  def setup
    @result = SalesEngine.from_csv({:items     => "../data/items.csv",
                          :merchants => "../data/merchants.csv"})
  end

  def test_from_csv_has_array_as_output
    assert_equal SalesEngine, @result.class
  end

  # def test_sales_engine_hash_contains_item_and_merchant_instances
  #   assert_equal Item, @result.items.first.class
  #   assert_equal Merchant, @result.merchants.first.class
  # end
  #
  # def test_can_get_item_names_and_merchant_names
  #   assert_equal "Minty Green Knit Crochet Infinity Scarf", @result.items.last.name
  #   assert_equal "CJsDecor", @result.merchants.last.name
  # end
  #
  # def test_from_csv_outputs_item_ids_and_merchant_ids
  #   assert_equal "263567474", @result.items.last.id
  #   assert_equal "12337411", @result.merchants.last.id
  # end
  #
  # def test_calling_merchants_creates_merchant_repo
  #   mr = @result.merchants
  #
  #   assert_equal MerchantRepository, mr.class
  # end

end
