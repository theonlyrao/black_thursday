class ItemRepository

  def initialize(item_array, sales_engine_instance = nil)
    @items = create_items(item_array, sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
  end

  def inspect
    "ItemRepo with #{@items.count} Items"
  end

  def create_items(item_array, sales_engine_instance)
    item_array.map do |hash_of_item_info|
      Item.new(hash_of_item_info, sales_engine_instance)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(search_string)
    results = @items.find_all do |item|
      item.description.downcase.include?(search_string.downcase)
    end
  end

  def find_all_by_price(price)
    items = @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    items = @items.find_all do |item|
      item if item.unit_price >= range.min && item.unit_price <= range.max
    end
  end

  def find_all_by_merchant_id(merchant_id)
    merchant_ids = @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

end
