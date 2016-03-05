require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({:items     => "../data/fixtures/item_stub.csv",
                                :merchants => "../data/merchants.csv"})
  end

  def test_analyst_created_with_instance_of_sales_engine
    sa = SalesAnalyst.new(@se)

    assert_equal SalesAnalyst, sa.class
  end

  def test_analyst_knows_avg_items_per_merchant
    sa = SalesAnalyst.new(@se)

    assert_equal 0.539, sa.average_items_per_merchant
  end

  def test_analyst_knows_st_dev_of_avg_items_per_merchant
    sa = SalesAnalyst.new(@se)

    assert_equal 1.41, sa.average_items_per_merchant_standard_deviation
  end

  def test_analyst_knows_merchants_selling_most_items
    sa = SalesAnalyst.new(@se)

    assert_equal 48, sa.merchants_with_high_item_count.count
  end

  def test_analyst_knows_avg_price_of_merchants_items
    sa = SalesAnalyst.new(@se)

    assert_equal BigDecimal.new(225, 4), sa.average_item_price_for_merchant(12334807)
  end

  def test_analyst_knows_avg_price_of_items_across_all_merchants
    sa = SalesAnalyst.new(@se)

    assert_equal BigDecimal.new(258.46,6), sa.average_average_price_per_merchant
  end

  def test_analyst_knows_avg_price_per_item
    sa = SalesAnalyst.new(@se)

    assert_equal 574.547890625, sa.average_price_per_item
  end

  def test_analyst_knows_st_dev_of_avg_prices_per_item
    sa = SalesAnalyst.new(@se)

    assert_equal 6250.0, sa.average_price_per_item_standard_deviation
  end

  def test_analyst_knows_golden_items
    sa = SalesAnalyst.new(@se)

    assert_equal 1, sa.golden_items.count
  end

end
