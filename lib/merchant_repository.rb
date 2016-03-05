class MerchantRepository

  def initialize(merchant_array, sales_engine_instance = nil)
    @merchants = create_merchants(merchant_array, sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
  end

  def inspect
    "MerchantRepo with #{@merchants.count} Merchants"
  end

  def create_merchants(merchant_array, sales_engine_instance)
    merchant_array.map do |hash_of_merchant_info|
      Merchant.new(hash_of_merchant_info, sales_engine_instance)
    end
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(search_string)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(search_string)
    end
  end


end
