class MerchantRepository

  def initialize(merchant_array)
    @merchants = merchant_array
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
      merchant.name.include?(search_string)
    end
  end


end
