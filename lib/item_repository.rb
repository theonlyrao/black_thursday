class ItemRepository

  def initialize(array_of_item_objects)
    @items = array_of_item_objects
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

  def find_all_by_price(integer)
    price = @items.find_all do |item|
      item.unit_price == integer
    end
  end

  def find_all_by_merchant_id(merchant_id)
    merchant_ids = @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

end
