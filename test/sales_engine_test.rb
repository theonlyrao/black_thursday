require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test


  def setup
    se = SalesEngine.new
    @result = se.from_csv({:items     => "./data/items.csv",
                          :merchants => "./data/merchants.csv"})
  end

  def test_from_csv_has_array_as_output
    assert_equal Hash, @result.class
  end

  def test_can_get_item_names_and_merchant_names
    item_names_array = @result[:items].map do |hash|
      hash[:name]
    end
    merchant_names_array = @result[:merchants].map do |hash|
      hash[:name]
    end

    assert_equal "Minty Green Knit Crochet Infinity Scarf", item_names_array.last
    assert_equal "CJsDecor", merchant_names_array.last
  end

  def test_from_csv_outputs_item_ids_and_merchant_ids
    item_ids_array = @result[:items].map do |hash|
      hash[:id]
    end
    merchant_ids_array = @result[:merchants].map do |hash|
      hash[:id]
    end

    assert_equal "263567474", item_ids_array.last
    assert_equal "12337411", merchant_ids_array.last
  end

end
