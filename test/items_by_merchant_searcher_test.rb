require 'minitest/autorun'
require 'pry'
require_relative '../lib/items_by_merchant_searcher'
require_relative '../lib/item'

class ItemsByMerchantSearcherTest < Minitest::Test

  def setup
    @item_1 = Item.new({id: 263395237,
                       name: "510+ RealPush Icon Set",
                       merchant_id: 12334141})
    item_2 = Item.new({id: 342395237,
                       name: "chocolate",
                       merchant_id: 2342141})
    @item_3 = Item.new({id: 543395237,
                       name: "pullup bar",
                       merchant_id: 12334141})
    @item_array = [@item_1, item_2, @item_3]
  end

  def test_can_look_up_a_merchants_items_in_itself
    searcher = ItemsByMerchantSearcher.new(12334141, @item_array)

    assert_equal [@item_1, @item_3], searcher.merchants_items
  end

end
