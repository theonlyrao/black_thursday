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
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchant = se.merchants.find_by_id(12335747)
    merchant_items = merchant.items

    assert_equal 7, merchant_items.count

  end
end
