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

  def test_sales_engine_hash_contains_item_and_merchant_instances
    assert_equal ItemRepository, @result.items.class
    assert_equal MerchantRepository, @result.merchants.class
  end

  # def test_from_csv_outputs_item_ids_and_merchant_ids
  #   assert_equal "263567474", @result.items.id
  #   assert_equal "12337411", @result.merchants.id
  # end

  # def test_calling_merchants_creates_merchant_repo
  #   mr = @result.merchants
  #
  #   assert_equal MerchantRepository, mr.class
  # end
  def test_array_has_a_merchants_array
  end
  def test_has_a_merchant_array
  end


#stub a csv/have a smaller csv to actually test
end
