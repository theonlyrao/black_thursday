require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
    @items = @test_helper.array_of_items
    @item_repository = ItemRepository.new(@items)
  end

  def test_all_returns_array_of_item_instances
    assert_equal Item, @item_repository.all.first.class
    assert_equal 3, @item_repository.all.count
    assert_equal 263395237, @item_repository.all.first.id
  end

  def test_find_by_id_returns_item_with_matching_id
    assert_equal "Googles", @item_repository.find_by_id(263395237).name
  #this returns object, how do I deal with the whole object because it's long
  end

  def test_find_by_id_returns_nil_when_none_match
    assert_equal nil, @item_repository.find_by_id(2)
  end

  def test_find_by_name_returns_instance_of_item
    assert_equal "Pencil", @item_repository.find_by_name("Pencil").name
  end

  def test_find_all_by_name_returns_nil_when_none_match
    assert_equal nil, @item_repository.find_by_name("bob")
  end

  def test_find_all_with_description_returns_an_empty_array
    assert_equal [], @item_repository.find_all_with_description("kjfskj")
  end

  def test_find_all_with_description_returns_a_populated_array
    assert_equal 2, @item_repository.find_all_with_description("you").count
  end

  def test_find_all_by_description_returns_an_empty_array_when_nothing_is_found
    assert_equal [], @item_repository.find_all_with_description("ashwin")
  end

  def test_find_all_by_price_returns_an_item_when_price_matches
    assert_equal "Googles", @item_repository.find_all_by_price(12.33)[0].name
  end

  def test_finds_item_by_price_within_a_range
    range = Range.new(0.50, 15)
    assert_equal 2, @item_repository.find_all_by_price_in_range(range).count
  end

  def test_find_all_by_price_in_range_returns_an_empty_array_when_nothing_is_found
    assert_equal [], @item_repository.find_all_by_price(2.00)
  end

  def test_find_all_by_price_in_range_return_items_in_an_array_that_match
    assert_equal Array, @item_repository.find_all_by_price(1.99).class
  end

  def test_find_all_by_merchant_id_returns_empty_array_when_none_match
    assert_equal [], @item_repository.find_all_by_merchant_id(7)
  end

  def test_find_all_by_merchant_id_returns_instances_of_item_where_merch_id_matches
    assert_equal 55555555, @item_repository.find_all_by_merchant_id(55555555)[0].merchant_id
  end


end
