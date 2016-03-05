require 'pry'
require 'bigdecimal'

class SalesAnalyst

  def initialize(sales_engine_instance)
    @sales_engine_instance = sales_engine_instance
  end

  def average_items_per_merchant
    total_items = @sales_engine_instance.items.all.count.to_f
    total_merchants = @sales_engine_instance.merchants.all.count.to_f

    average_items_per_merchant = BigDecimal.new(total_items/total_merchants, 3).to_f
    average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    average_items_per_merchant

    num_items_per_merchant = @sales_engine_instance.merchants.all.map do |merchant|
      merchant.items.count
    end

    differences = num_items_per_merchant.map do |num_items|
      num_items - average_items_per_merchant
    end

    square_diff = differences.map { |difference| difference ** 2}
    sum_of_squares = square_diff.reduce(:+)

    num_merchants = @sales_engine_instance.merchants.all.count.to_f
    divisor = num_merchants - 1

    raw_standard_deviation = Math.sqrt(sum_of_squares/divisor)
    standard_deviation = BigDecimal.new(raw_standard_deviation, 3).to_f
    standard_deviation
  end

  def merchants_with_high_item_count
    high_num_of_items = average_items_per_merchant + average_items_per_merchant_standard_deviation

    merchants_by_item_count_hash = @sales_engine_instance.merchants.all.group_by do |merchant|
      merchant.items.count
    end

    almost_there_array = merchants_by_item_count_hash.find_all do |key, value|
      value if key > high_num_of_items
    end.flatten

    merchants_with_high_item_count = almost_there_array.partition do |element|
      element.class == Merchant
    end.first
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine_instance.merchants.find_by_id(merchant_id)

    merchants_items = merchant.items

    sum_of_prices_of_all_merchants_items = merchants_items.map do |item|
      item.unit_price
    end.reduce(:+).to_f

    num_merchants_items = merchants_items.count.to_f
    average_item_price_for_merchant = BigDecimal.new(sum_of_prices_of_all_merchants_items/num_merchants_items, 4)
  end

  def average_average_price_per_merchant
    # get merchant ids for each merchant
    all_merchant_ids = @sales_engine_instance.merchants.all.map do |merchant|
      merchant.id
    end
    # get total number of merchants
    total_number_merchants = @sales_engine_instance.merchants.all.count.to_f
    # get average item price for each merchant
    # sum up average prices
    average_item_price_per_merchant = all_merchant_ids.map do |id|
      if @sales_engine_instance.merchants.find_by_id(id).items.count > 0
        result = average_item_price_for_merchant(id)
      end
      result.to_f
    end.reduce(:+)
    # divide sum by total number of merchants
    average_average_price_per_merchant = BigDecimal.new(average_item_price_per_merchant/total_number_merchants, 6)
  end

end
