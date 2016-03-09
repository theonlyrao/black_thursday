require 'minitest/autorun'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_repository = ItemRepository.new
    @item_repository.from_csv("./data/fixtures/item_stub.csv")
  end

  def test_can_create_repo_from_sales_engine
    se = SalesEngine.from_csv({:items     => "./data/fixtures/item_stub.csv"})

    assert_equal ItemRepository, se.items.class
    assert_equal "ItemRepo with 256 Items", se.items.inspect
  end

  def test_all_returns_array_of_item_instances
    assert_equal Item, @item_repository.all.first.class
    assert_equal 256, @item_repository.all.count
    assert_equal 263395237, @item_repository.all.first.id
  end

  def test_find_by_id_returns_item_with_matching_id
    assert_equal "510+ RealPush Icon Set", @item_repository.find_by_id(263395237).name
  end

  def test_find_by_id_returns_nil_when_none_match
    assert_equal nil, @item_repository.find_by_id(2)
  end

  def test_find_by_name_returns_instance_of_item
    assert_equal "Etre ailleurs", @item_repository.find_by_name("Etre ailleurs").name
  end

  def test_find_all_by_name_returns_nil_when_none_match
    assert_equal nil, @item_repository.find_by_name("bob")
  end

  def test_find_all_with_description_returns_an_empty_array
    assert_equal [], @item_repository.find_all_with_description("kjfskj")
  end

  def test_find_all_with_description_returns_a_populated_array
    assert_equal 88, @item_repository.find_all_with_description("you").count
  end

  def test_find_all_by_description_returns_an_empty_array_when_nothing_is_found
    assert_equal [], @item_repository.find_all_with_description("ashwin")
  end

  def test_find_all_by_price_returns_an_item_when_price_matches
    assert_equal "Course contre la montre", @item_repository.find_all_by_price(400.00)[0].name
  end

  def test_finds_item_by_price_within_a_range
    range = Range.new(0.50, 15)
    assert_equal 67, @item_repository.find_all_by_price_in_range(range).count
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
    assert_equal 263395237, @item_repository.find_all_by_merchant_id(12334141)[0].id
  end


end
