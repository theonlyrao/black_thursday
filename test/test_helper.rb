require_relative '../lib/item'

class TestHelper
  def array_of_items
		[Item.new({
      :id          => "263395237",
      :name        => "Googles",
      :description => "Good for oogling while scooba-ing",
      :unit_price  => BigDecimal.new(1233, 4),
      :merchant_id => "12345678",
      :created_at  => "1993-09-29 11:56:40 UTC",
      :updated_at  => "1993-09-29 11:56:40 UTC"}),
	  Item.new({
      :id          => "263395237",
      :name        => "Pencil",
	    :description => "You can use it to write things",
	    :unit_price  => BigDecimal.new(333, 4),
	    :merchant_id => "55555555",
	    :created_at  => "1993-09-29 11:56:40 UTC",
	    :updated_at  => "1993-09-29 11:56:40 UTC"}),
		Item.new({
		  :id          => "263395237",
		  :name        => "Feet",
		  :description => "You did something wrong if you don't already have these.",
		  :unit_price  => BigDecimal.new(43330, 4),
		  :merchant_id => "33333333",
		  :created_at  => "1993-09-29 11:56:40 UTC",
		  :updated_at  => "1993-09-29 11:56:40 UTC"})]
	end

end
