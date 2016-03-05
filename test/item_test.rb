require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    @i = Item.new({
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal.new(1099,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
      })
  end

  def test_item_can_be_created
    assert_equal Item, @i.class
  end

  def test_id_returns_id_of_item
  end

  def test_name_returns_name_of_item
    assert_equal "Pencil", @i.name
  end

  def test_description_returns_description
    assert_equal "You can use it to write things", @i.description
  end

  def test_unit_price_returns_big_decimal
    assert_equal 10.99, @i.unit_price
  end

  def test_created_at_returns_time_of_creation
    assert_equal Time, @i.created_at.class
  end

  def test_updated_at_returns_time_of_creation
    assert_equal Time, @i.updated_at.class
  end

  def test_merchant_id_returns_merchant_id
  end

  def test_unit_price_to_dollars_returns_price_as_float
    dollars = @i.unit_price_to_dollars

    assert_equal Float, dollars.class
  end

end
