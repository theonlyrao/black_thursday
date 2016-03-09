module PriceMethods

    def average_item_price_for_merchant(merchant_id)
      merchant = @sales_engine_instance.merchants.find_by_id(merchant_id)

      merchants_items = merchant.items

      sum_of_prices_of_all_merchants_items = merchants_items.map do |item|
        item.unit_price
      end.reduce(:+).to_f

      num_merchants_items = merchants_items.count.to_f
      BigDecimal(sum_of_prices_of_all_merchants_items/num_merchants_items, 4)
    end

    def average_average_price_per_merchant
      all_merchant_ids = @sales_engine_instance.merchants.all.map do |merchant|
        merchant.id
      end

      merchant_count = BigDecimal(@sales_engine_instance.merchants.all.count)

      average_item_price_per_merchant = all_merchant_ids.map do |id|
        if @sales_engine_instance.merchants.find_by_id(id).items.count > 0
          result = average_item_price_for_merchant(id)
        else
          result = BigDecimal("0")
        end
        result
      end.reduce(:+)

      answer = average_item_price_per_merchant/merchant_count
      answer.truncate(2)
    end

    def average_price_per_item
      total_items = @sales_engine_instance.items.all.count.to_f
      total_of_all_items = @sales_engine_instance.items.all.map do |item|
        item.unit_price
      end.reduce(:+)

      BigDecimal.new(total_of_all_items/total_items, 3).to_f
    end

    def average_price_per_item_standard_deviation
      price_of_each_item = @sales_engine_instance.items.all.map do |item|
        item.unit_price
      end

      standard_deviation(price_of_each_item, average_price_per_item)
    end

end
