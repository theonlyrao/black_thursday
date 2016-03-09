require_relative 'repository_methods'
require_relative 'merchant'
require 'csv'

class MerchantRepository

  include RepositoryMethods

  def initialize
    @things = []
  end

  def inspect
    "MerchantRepo with #{@things.count} Merchants"
  end

  def from_csv(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
    merchants = contents.map do |row|
      row.to_h
    end
    create_merchant_items(merchants)
  end

  def create_merchant_items(merchant_array, sales_engine_instance = nil)
    @sales_engine_instance = sales_engine_instance
    @things = merchant_array.map do |hash_of_merchant_info|
      Merchant.new(hash_of_merchant_info, sales_engine_instance)
    end
    unless @sales_engine_instance.nil?
      @sales_engine_instance.merchants = self
    end
  end

end
