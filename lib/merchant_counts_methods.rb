module MerchantCountsMethods

    def merchants_with_high_count_of_things(thing)
      if thing == :invoices
        deviations = 2
      else
        deviations = 1
      end

      high_num_of_things = average_num_of_things_per_merchant(thing) + (average_num_of_things_per_merchant_standard_deviation(thing) * deviations)

      merchants_by_thing_count_hash = @sales_engine_instance.merchants.all.group_by do |merchant|
        if thing == :invoices
          merchant.invoices.count
        else
          merchant.items.count
        end
      end

      almost_there_array = merchants_by_thing_count_hash.find_all do |key, value|
        value if key > high_num_of_things
      end.flatten

      merchants_with_high_count_of_things = almost_there_array.partition do |element|
        element.class == Merchant
      end.first
    end

    def top_merchants_by_invoice_count
      merchants_with_high_count_of_things(:invoices)
    end

    def merchants_with_high_item_count
      merchants_with_high_count_of_things(:items)
    end

end
