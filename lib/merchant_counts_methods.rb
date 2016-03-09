module MerchantCountsMethods

    def top_merchants_by_invoice_count
      merchants_with_particular_count_of_things(:invoices, :high)
    end

    def merchants_with_high_item_count
      merchants_with_particular_count_of_things(:items, :high)
    end

    def bottom_merchants_by_invoice_count
      merchants_with_particular_count_of_things(:invoices, :low)
    end

    def merchants_with_particular_count_of_things(thing, high_or_low = :high)
      if thing == :invoices && high_or_low == :high
        deviations = 2
      elsif thing == :invoices && high_or_low == :low
        deviations = -2
      else
        deviations = 1
      end

      average = average_num_of_things_per_merchant(thing)
      d = average_num_of_things_per_merchant_standard_deviation(thing)
      adj_deviation = d * deviations
      relevant_num_of_things = average + adj_deviation

      merchants = @sales_engine_instance.merchants
      merchants_and_count = merchants.all.group_by do |merchant|
        if thing == :invoices
          merchant.invoices.count
        else
          merchant.items.count
        end
      end

      results = merchants_and_count.find_all do |key, value|
        if high_or_low == :high
          value if key > relevant_num_of_things
        else
          value if key < relevant_num_of_things
        end
      end.flatten

      merchants_with_particular_count_of_things = results.partition do |element|
        element.class == Merchant
      end.first
    end

end
