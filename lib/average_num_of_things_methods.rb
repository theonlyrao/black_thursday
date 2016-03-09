module AverageNumOfThingsMethods

    def average_num_of_things_per_merchant(thing)
      if thing == :invoices
        total_things = @sales_engine_instance.invoices.all.count.to_f
        digits = 4
      else
        total_things = @sales_engine_instance.items.all.count.to_f
        digits = 3
      end

      total_merchants = @sales_engine_instance.merchants.all.count.to_f

      BigDecimal.new(total_things/total_merchants, digits).to_f
    end

    def average_invoices_per_merchant
      average_num_of_things_per_merchant(:invoices)
    end

    def average_items_per_merchant
      average_num_of_things_per_merchant(:items)
    end

    def average_items_per_merchant_standard_deviation
      average_num_of_things_per_merchant_standard_deviation(:items)
    end

    def average_invoices_per_merchant_standard_deviation
      average_num_of_things_per_merchant_standard_deviation(:invoices)
    end

    def average_num_of_things_per_merchant_standard_deviation(thing)
      if thing == :invoices
        merchant_things = @sales_engine_instance.merchants.all.map do |merchant|
          merchant.invoices.count
        end
      else
        merchant_things = @sales_engine_instance.merchants.all.map do |merchant|
          merchant.items.count
        end
      end

      sample_mean = average_num_of_things_per_merchant(thing)
      standard_deviation(merchant_things, sample_mean)
    end

end
