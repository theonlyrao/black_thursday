class MerchantRepository

  def initialize(merchant_array, <SOME CONNECTION TO OTHER DATA>.... (sales engine, item repo))
    # taking an array of merchants and storing them
    # but...
    # I also need some ability for my merchants to ask about specific items

    # what things can answer questions about specific items?
    # -> sales_engine.item_repo

    # Need to figure out some way to connect an individual merchant to the
    # item_repository (which is currently stored in the SalesEngine object)

    # 1. Could pass the SalesEngine to each merchant so it can refer to it when it needs to ask these questions
    # 2. Could pass the ItemRepository to each merchant
    # 3. Could pass the MerchantRepository to each merchant and.... make sure merchant repo can somehow
    #    connect to item repo (either by referring to it directly or by referring to the sales engine)
    @merchants = merchant_array
  end

  def inspect
    "MerchantRepo with #{@merchants.count} Merchants"
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
