require_relative 'repository_methods'

class ItemRepository

  include RepositoryMethods

  def initialize
    @things = []
  end

  def inspect
    "ItemRepo with #{@things.count} Items"
  end

  def from_csv(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
    items = contents.map do |row|
      row.to_h
    end
    create_item_items(items)
  end

  def create_item_items(item_array, sales_engine_instance = nil)
    @sales_engine_instance = sales_engine_instance
    @things = item_array.map do |hash_of_item_info|
      Item.new(hash_of_item_info, sales_engine_instance)
    end
    unless @sales_engine_instance == nil
      @sales_engine_instance.items = self
    end
  end

end
