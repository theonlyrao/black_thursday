require_relative 'repository_methods'

class MerchantRepository

  include RepositoryMethods

  def initialize(merchant_array, sales_engine_instance = nil)
    @things = create_merchants(merchant_array, sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
  end

  def inspect
    "MerchantRepo with #{@things.count} Merchants"
  end

  def create_merchants(merchant_array, sales_engine_instance)
    merchant_array.map do |hash_of_merchant_info|
      Merchant.new(hash_of_merchant_info, sales_engine_instance)
    end
  end

end
