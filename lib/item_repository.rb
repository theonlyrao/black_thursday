require_relative 'repository_methods'

class ItemRepository

  include RepositoryMethods

  def initialize(item_array, sales_engine_instance = nil)
    @things = create_items(item_array, sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
  end

  def self.send_csv_contents_to_repo(item_hash, sales_engine_instance)
    ItemRepository.new(item_hash, sales_engine_instance)
  end

  def inspect
    "ItemRepo with #{@things.count} Items"
  end

  def create_items(item_array, sales_engine_instance)
    item_array.map do |hash_of_item_info|
      Item.new(hash_of_item_info, sales_engine_instance)
    end
  end

end
